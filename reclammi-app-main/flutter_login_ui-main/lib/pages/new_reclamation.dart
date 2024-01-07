import 'dart:convert';
import 'dart:io';
import 'package:flutter_login_ui/pages/profile_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'ComplaintList.dart';
import 'globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';


import 'config.dart';
class NewReclamationForm extends StatefulWidget {

  final List<String> complaintTypes;
  final String type ;
  const NewReclamationForm( {required this.type,required this.complaintTypes,Key? key}) : super(key: key);

  String get token => globals.authToken;


  @override
  _NewReclamationFormState createState() => _NewReclamationFormState();
}

class _NewReclamationFormState extends State<NewReclamationForm> {
  TextEditingController _titreController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FilePickerResult?Result;
  String? filename;
  PlatformFile?pickedfile;
  bool isloading= false;
  File? filetoshow ;
  String lat ='Null, Press Button';
  String long ='Null, Press Button';
  String Address = '';
  String path='' ;

  Future<void> getImage() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    path =image!.path;
  }

  String? _location;
  String _complaintType = '';
  String _description = '';

  List<String> _complaintTypes = [];
  late String? userID;
  late String _type;
  @override
  void initState() {
    super.initState();
    _complaintTypes = widget.complaintTypes;
    _complaintType = _complaintTypes.first;
    _type = widget.type ;

    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userID=jwtDecodedToken['_id'];

  }

  void _updateComplaintTypes(int index, String newType) {
    setState(() {
      _complaintTypes[index] = newType;
    });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.administrativeArea}, ${place.subAdministrativeArea},  ${place.country}';
    print(place);
    setState(()  {
    });
  }

  void addcomp() async {
    if (_titreController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _textEditingController.text.isNotEmpty) {
      setState(() {
        isloading = true;
      });

      var request = http.MultipartRequest("POST", Uri.parse(create));
      request.fields['title'] = _titreController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['submitter'] = userID!;
      request.fields['location'] = jsonEncode({
        "address": _textEditingController.text,
        "latitude": lat,
        "longitude": long,
      }); // Convert location to a JSON string
      request.fields['type'] = jsonEncode({
        'type': _type,
        'soustype': _complaintType,
      }); // Convert type to a JSON string

      if (path != '') {
        var file = await http.MultipartFile.fromPath(
          'file',
          path,
          contentType: MediaType('image', 'jpeg'),
        ); // Adjust the content type as per your image file type

        request.files.add(file);
      }
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          print("uploaded");

          } else {
          print("Upload failed with status code: ${response.statusCode}");
        }
      } catch (error) {
        print(error);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text('New Reclamation'),
      ),
      body: SingleChildScrollView(
        child: Container(color: Colors.grey[100],
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins' ,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Give a title',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins' ,
                        fontSize: 18.0,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    controller: _titreController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please give a title';
                      }
                      return null;
                    },

                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Entrer your location:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Location',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.location_on),
                            onPressed: () async {
                              Position position = await _getGeoLocationPosition();
                              lat = '${position.latitude}';
                              long = ' ${position.longitude}';
                              GetAddressFromLatLong(position);
                              setState(() {
                                _textEditingController.text = Address;
                              });
                              print(Address);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),

                      // To show the value returned in the location place
                    ],
                  ),

                  SizedBox(height: 16.0),
                  Text(
                    'Select the type of reclamation:',
                    style: TextStyle(
                      fontFamily: 'Poppins' ,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _complaintTypes
                        .map(
                          (type) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _complaintType = type;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                          _complaintType == type ? Colors.teal : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontFamily: 'Poppins' ,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'description:',
                        style: TextStyle(
                          fontFamily: 'Poppins' ,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Your description',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins' ,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        controller:  _descriptionController ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Text(
                        'Add a picture',
                        style: TextStyle(fontFamily: 'Poppins' ,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        addcomp ();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(token: widget.token),)
                        );

                      },
                      child: Text(
                        'Submit reclamation',
                        style: TextStyle(fontFamily: 'Poppins' ,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


