import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:latlong2/latlong.dart';
import 'ComplaintPopup.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'config.dart';

class ComplaintMap extends StatefulWidget {
  const ComplaintMap({Key? key}) : super(key: key);

  String get token => globals.authToken;
  @override
  State<ComplaintMap> createState() => _ComplaintMapState();
}

class _ComplaintMapState extends State<ComplaintMap> {
  List<dynamic>? complaints;
  String? userID;

  @override
  void initState() {
    super.initState();
    getcomplaint();
  }

  void getcomplaint() async {
    var reqBody = {
      "filterType": "",
    };

    var responce = await http.post(Uri.parse(complaintA),
        headers: {"content-type": "application/json"},
        body: jsonEncode(reqBody));
    print('Response status code: ${responce.statusCode}');
    print('Response status message: ${responce.reasonPhrase}');
    print('Response body: ${responce.body}');

    var jsonResponse = jsonDecode(responce.body);
    print(jsonResponse);
    print(jsonResponse['success']);
    try {
      complaints = jsonResponse['success'];
    } catch (error) {
      print("Error: $error");
      // Handle the error as needed
    }
    setState(() {
      complaints = jsonResponse['success'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('carte des reclamation'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(34.8350, 9.5357),
          zoom: 7.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: complaints?.map((complaint) {
              var color;
              switch (complaint['status']) {
                case 'pending':
                  color = Colors.red;
                  break;
                case 'inProgress':
                  color = Colors.orange;
                  break;
                case 'resolved':
                  color = Colors.green;
                  break;
                default:
                  color = Colors.grey;
              }
              return Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                  complaint['location']['latitude'],
                  complaint['location']['longitude'],
                ),
                builder: (ctx) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ComplaintPopup(
                          title: complaint['title'],
                          description: complaint['description'],
                          // fileData: complaint['file'],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.location_pin,
                      color: color,
                      size: 40.0,
                    ),
                  );
                },
              );
            }).toList()?? [],
          ),
        ],
      ),
    );
  }


}
