import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class profil extends StatefulWidget {
  final id;

  profil({required this.id});

  @override
  _profilState createState() => _profilState();
}

class _profilState extends State<profil> {
  TextEditingController _duration = TextEditingController();
  var user;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    var reqBody = {
      "userId": widget.id,
    };

    var response = await http.post(
      Uri.parse(getinf),
      headers: {"content-type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(jsonResponse['success']);

    try {
      user = jsonResponse['success']; // Declare the user variable here
      setState(() {
        user = jsonResponse['success'];
        isAdmin = user?['isAdmin'] ?? false;
      });
    } catch (error) {
      print(widget.id);
      print("Error: $error");
      // Handle the error as needed
    }
  }

  void ban() async {
    var reqBody = {
      "userId": widget.id,
      "durationInDays": _duration.text,
    };

    var response = await http.post(
      Uri.parse(banner),
      headers: {"content-type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(jsonResponse['success']);

    try {
      user = jsonResponse['success']; // Declare the user variable here
      setState(() {
        user = jsonResponse['success'];
      });
      _duration.clear();
      Navigator.pop(context);
    } catch (error) {
      print("Error: $error");
      // Handle the error as needed
    }
  }

  void grantAdminPrivilege() async {
    var reqBody = {
      "userId": widget.id,
    };

    var response = await http.post(
      Uri.parse(grant),
      headers: {"content-type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(jsonResponse['success']);

    try {
      user = jsonResponse['success']; // Declare the user variable here
      setState(() {
        user = jsonResponse['success'];
      });
    } catch (error) {
      print("Error: $error");
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 5, color: Colors.white),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey.shade300,
                size: 80.0,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              children: <Widget>[
                Text(
                  '${user?['firstName']} ${user?['lastName']}',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isAdmin)
                  Text(
                    'Application administrator',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: Colors.teal.shade100,
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    'Application user',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: Colors.teal.shade100,
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 40.0,
              width: 200.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.teal,
                ),
                title: Text(
                  '${user?['mobileNumber']} ',
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal,
                ),
                title: Text(
                  '${user?['email']} ',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            if (user?['isBanned']==true)
              Center(
                child: Text(
                  'User is currently banned',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.teal.shade100,
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            if (!isAdmin)
              ElevatedButton(
                onPressed: () {
                  grantAdminPrivilege();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                ),
                child: Text(
                  'Grant Admin privilege',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            if (user?['isBanned']==false)
              ElevatedButton(
                onPressed: () {
                  _displayTextInputDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                ),
                child: Text(
                  'Bannir',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add the duration of the ban'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _duration,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ban();
                },
                child: Text("Ban"),
              )
            ],
          ),
        );
      },
    );
  }
}
