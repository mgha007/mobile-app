import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home:LoginPage(),
      // home: SplashScreen(
      //   onNavigate: (isValid) {
      //     Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(
      //         builder: (context) =>
      //         isValid ? ProfilePage(token: token) : LoginPage(),
      //       ),
      //           (route) => false,
      //     );
      //   },
      //   token: token ?? "", // Use the non-null assertion operator (!) since token is guaranteed to not be null inside the MyApp widget
      // ),
    );
  }
}
