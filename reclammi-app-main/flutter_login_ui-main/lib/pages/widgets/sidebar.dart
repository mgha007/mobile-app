import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/pages/mypost.dart';
import 'package:flutter_login_ui/pages/new_reclamation.dart';
import '../ComplaintListt.dart';
import '../ComplaintMap.dart';
import '../ComplaintStatusPieChart.dart';
import '../globals.dart' as globals;

import '../ComplaintList.dart';
import '../profile_page.dart';


class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);
  String get token => globals.authToken;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Reclammi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily:'Poppins',
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 16, color: Colors.black,fontFamily:'Poppins',),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(token: token)),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt_rounded,
                color: Colors.black,
              ),
              title: Text(
                'Mes Posts',
                style: TextStyle(fontSize: 16, color: Colors.black,fontFamily:'Poppins',),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintList(),)
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt_rounded,
                color: Colors.black,
              ),
              title: Text(
                'tout les  Posts',
                style: TextStyle(fontSize: 16, color: Colors.black,fontFamily:'Poppins',),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => toutlespost(),)
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.stacked_bar_chart_rounded,
                color: Colors.black,
              ),
              title: Text(
                'Statistiques',
                style: TextStyle(fontSize: 16, color: Colors.black,fontFamily:'Poppins',),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintStatusPieChart()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.location_city_sharp,
                color: Colors.black,
              ),
              title: Text(
                'Map',
                style: TextStyle(fontSize: 16, color: Colors.black,fontFamily:'Poppins',),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintMap()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
              title: Text(
                'Se déconnecter',
                style: TextStyle(fontSize: 16, color: Colors.black,fontFamily:'Poppins',),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}