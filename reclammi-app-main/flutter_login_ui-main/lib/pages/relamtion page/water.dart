import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';

import '../new_reclamation.dart';
import '../widgets/widgets.dart';

class water extends StatefulWidget {
  const water({Key? key}): super(key:key);

  @override
  State<water> createState() => _waterState();
}

class _waterState extends State<water> {
  String type ="eau";
  final List<String> complaintTypes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('Water'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height*0.85 ,
          child: Column(
           children: [
             alignCard(icon: Icons.phone_in_talk, title: 'Customer Service',  page: NewReclamationForm(type:type,complaintTypes: ['Service Clients','Interruptions de service','Pression de leau','Problèmes de facturation et de paiement','La qualité d eau'],), context: context),
             alignCard(icon: CupertinoIcons.scissors, title: 'Service Interruption',  page: NewReclamationForm(type:type,complaintTypes: ['Interruptions de service','Service Clients','Pression de leau','Problèmes de facturation et de paiement'],), context: context),
             alignCard(icon: CupertinoIcons.paragraph, title: 'Water Pressure',  page: NewReclamationForm(type:type,complaintTypes: ['Pression de leau','Service Clients','Interruptions de service','Problèmes de facturation et de paiement','La qualité d eau'],), context: context),
             alignCard(icon: CupertinoIcons.money_dollar, title: 'Problems in payment', page: NewReclamationForm(type:type,complaintTypes: ['Problèmes de facturation et de paiement','Service Clients','Interruptions de service','Pression de leau','La qualité d eau'],), context: context),
             alignCard(icon: Icons.mark_chat_read_outlined, title: 'Other', page: NewReclamationForm(type:type,complaintTypes: ['Autre','Service Clients','Interruptions de service','Pression de leau','Problèmes de facturation et de paiement'],), context: context),
           ],
          ),
        )
    );
  }
}
