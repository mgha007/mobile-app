import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../ComplaintDetailsScreen.dart';
import '../ComplaintScreenAdmin.dart';
import '../globals.dart' as globals;
import '../config.dart';

class enTendence extends StatefulWidget {
  const enTendence({Key? key}) : super(key: key);
  String get token => globals.authToken;
  @override
  State<enTendence> createState() => _enTendenceState();
}

class _enTendenceState extends State<enTendence> {
  List? complaints;
  late bool isadmin;
  @override
  void initState() {
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    isadmin=jwtDecodedToken['isAdmin'];
    fetchComplaints();
  }

  void fetchComplaints() async {
    var response = await http.get(Uri.parse(enT));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        if (jsonResponse['success'] is List) {
          complaints = jsonResponse['success'].cast<Map<String, dynamic>>();
        } else {
          print('Invalid response format: success is not a list.');
        }
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: complaints?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final bool isAdmin =isadmin; // Check the "admin" property in the token;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => isAdmin
                      ? admin( complaint: complaints![index],
                    id: complaints![index]['_id'],) // Navigate to admin screen
                      : ComplaintDetailsScreen(
                    complaint: complaints![index],
                    id: complaints![index]['_id'],
                  ), // Navigate to complaint details screen
                ),
              );
            },
            child: Container(
              width: 300,
              height: MediaQuery.of(context).size.height * 0.8,
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${complaints?[index]['title']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            '${complaints?[index]['status']}' == 'resolved'
                                ? Icons.check_circle
                                : '${complaints?[index]['status']}' == 'pending'
                                ? Icons.warning
                                : Icons.close_rounded,
                            color: '${complaints?[index]['status']}' == 'resolved'
                                ? Colors.green
                                : '${complaints?[index]['status']}' == 'pending'
                                ? Colors.orange
                                : Colors.red,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Container(width: 200,
                            child: Text(
                              '${complaints?[index]['location']['address']}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(width: 300,
                        child: Text(
                          '${complaints?[index]['description']}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${complaints?[index]['submitter']['firstName']}  ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
