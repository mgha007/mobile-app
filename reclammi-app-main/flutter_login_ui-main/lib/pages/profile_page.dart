
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/pages/notification.dart';
import 'package:flutter_login_ui/pages/pdf_page.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/consumer%20affer.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/education.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/electricity.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/environement.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/medical.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/transport.dart';
import 'package:flutter_login_ui/pages/relamtion%20page/water.dart';
import 'package:flutter_login_ui/pages/widgets/enTendence.dart';
import 'package:flutter_login_ui/pages/widgets/widgets.dart';

import 'ComplaintList.dart';
import 'new_reclamation.dart';
import 'widgets/sidebar.dart';



class ProfilePage extends StatefulWidget{
  final token ;
  const ProfilePage( {@required this.token,Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}


class _ProfilePageState extends State<ProfilePage>{
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text("Home",
          style: TextStyle(
              fontFamily:'Poppins',color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace:Container(
        ),
      ),
      drawer: DrawerWidget (),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/street.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 15.0, bottom: 4.0),
              alignment: Alignment.topLeft,
              child: Container(  padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal[400],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0,1.5),
                    ),
                  ],
                ),

                child: Text(
                  "The most popular complaints",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      enTendence(),
                    ],
                  ),
                )
            ) ,
            SizedBox(height: 30,),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 4.0),
                  alignment: Alignment.topLeft,
                  child: Container(  padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal[400],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0,1.5),
                        ),
                      ],
                    ),
                    child: Text(
                      "All types of complaints ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height *1.25,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCard(icon: Icons.edit_note, title: 'Education', subtitle: 'Quality of education/ Access and accommodation',page: education(),context: context, ),
                        customCard(icon: Icons.medication_sharp, title: 'Health', subtitle: ' Medical errors / Quality of care ',page: Medical(),context: context, )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCard(icon: Icons.add_road_outlined, title: 'Transportation', subtitle: 'Accessibility, Quality of service ',page: transport(),context: context, ),
                        customCard(icon: Icons.water_sharp, title: 'eau', subtitle: 'Quality of service / Water quality',page: water(),context: context, )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCard(icon: Icons.location_city, title: 'Consumer Affairs', subtitle: 'Unfair business practices',page:consumer(),context: context, ),
                        customCard(icon: Icons.electric_bolt, title: 'electricity', subtitle: 'Payment issues /  Quality of service ',page: electricity(),context: context, )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCard(icon: Icons.electric_bolt, title: 'Environment', subtitle: 'Air Pollution/ Street Pollution',page: environement(),context: context, ),
                        customCard(icon: Icons.mark_chat_read_outlined, title: 'Other', subtitle: '',page: NewReclamationForm(type:"Other",complaintTypes: ['Other'] ,),  context: context, )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]

    ),
        )
    ),
    );
  }

}
