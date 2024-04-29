import 'package:jwt_decoder/jwt_decoder.dart';

import 'globals.dart' as globals;
import 'dart:convert';
import 'new_reclamation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initsharedprefs();
  }
  void initsharedprefs() async{
    prefs= await SharedPreferences.getInstance();
  }

  void loginuser() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": _emailController.text,
        "password": _passwordController.text
      };

      var response = await http.post(
        Uri.parse(login),
        headers: {"content-type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse.containsKey('token')) {
        var myToken = jsonResponse['token'];
        Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(myToken);
        bool banned=jwtDecodedToken['isBanned'];

        globals.authToken = myToken;
        prefs.setString('token', myToken);

        if (banned) {
          // Handle "banned" condition
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Banned'),
                content: Text('Vous êtes actuellement banni. Veuillez contacter support.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ProfilePage(token: myToken)),
                (Route<dynamic> route) => false,
          );
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 1, 20, 10),
                margin: EdgeInsets.fromLTRB(
                    20, 1, 20, 10), // This will be the login form
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                controller: _emailController,
                                decoration: ThemeHelper().textInputDecoration(
                                    'E-mail', 'Enter votre email'),
                              ),
                              decoration:
                              ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Password', 'Enter votre mot de passe'),
                              ),
                              decoration:
                              ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPasswordPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'Log In'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  loginuser ();

                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: "Don\'t have an account? ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RegistrationPage(),
                                          ),
                                        );
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}