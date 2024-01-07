import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'ComplaintDetailsScreen.dart';
import 'ComplaintScreenAdmin.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart'as http;
import 'config.dart';
import 'profil.dart';

class toutlespost extends StatefulWidget {
  const toutlespost({Key? key}) : super(key: key);

  String get token => globals.authToken;
  @override
  State<toutlespost> createState() => _ComplaintListState();
}
class _ComplaintListState extends State<toutlespost> {
  List? complaints;
  String? _selectedCategory;
  late bool isadmin;
  @override
  void initState(){
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    isadmin=jwtDecodedToken['isAdmin'];
    getcomplaint(_selectedCategory);
  }

  void getcomplaint(value) async {
    var reqBody = {
      "filterType": value,
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
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text('List of complaints'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration.collapsed(
                hintText: 'Filter by category',
              ),
              value: _selectedCategory,
              items: [
                'All complaints',
                'Education',
                'Health',
                'Water',
                'Transportation',
                'Electricity',
                'Consumer affair',
                'Environment',
                'Other',
              ]
                  .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  getcomplaint(value);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          complaints == null
              ? CircularProgressIndicator() // Show a loading indicator while data is being fetched
              : complaints!.isEmpty
              ? Text('No complaints found') // Show a message when no complaints are available
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: complaints!.length,
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${complaints![index]['title']  ?? '' }',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            '${complaints![index]['status']}' == 'resolved'
                                ? Icons.check_circle
                                : '${complaints![index]['status']}' == 'pending'
                                ? Icons.warning
                                : Icons.close_rounded,
                            color: '${complaints![index]['status']}' == 'resolved'
                                ? Colors.green
                                : '${complaints![index]['status']}' == 'pending'
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
                          Container(
                            width: 200,
                            child: Text(
                              '${ complaints![index]['location']?['address'] ?? '' }',
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
                      Container(
                        width: 300,
                        child: Text(
                          '${ complaints![index]['description'] ?? '' }',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person)
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${complaints![index]['submit']?["firstName"] ?? '' }',

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
