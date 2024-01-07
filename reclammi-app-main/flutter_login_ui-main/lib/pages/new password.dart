import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:http/http.dart'as http;
import 'config.dart';
import 'login_page.dart';
import 'widgets/header_widget.dart';

class newpassword extends StatefulWidget {
  final  email ;
  final reset;
  newpassword({required this.email,required this.reset});

  @override
  _newpasswordState createState() => _newpasswordState();
}

class _newpasswordState extends State<newpassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passController = TextEditingController();


  void resete () async {
    if(
    _passController.text.isNotEmpty
    ){
      var regBody = {

        "email":widget.email,
        "resetCode":widget.reset,
        "newPassword":_passController.text,

      };
      var responce = await http.post(Uri.parse(reset),
          headers: {"content-type":"application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(responce.body);
      print(jsonResponse);
      if (jsonResponse['status'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()),
        );
      }



    }
  }
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true, Icons.password_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration("mot de pass", "Enter your mot de pass"),
                                controller: _passController,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "mot de passe can't be empty";
                                  }

                                },
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      40, 10, 40, 10),
                                  child: Text(
                                    "Send".toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if(_formKey.currentState!.validate()) {
                                    resete ();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
