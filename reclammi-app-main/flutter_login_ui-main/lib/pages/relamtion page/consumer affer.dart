import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';

import '../new_reclamation.dart';
import '../widgets/widgets.dart';

class consumer extends StatefulWidget {
  const consumer({Key? key}): super(key:key);


  @override
  State<consumer> createState() => _consumerState();
}

class _consumerState extends State<consumer> {
  String type="Consumer affair";
   List<String> complaintTypes = ['Type 1', 'Type 2', 'Type 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('Consumer affair'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/street.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height ,
          child: Column(
            children: [
              alignCard(icon: Icons.phone_in_talk, title: 'Customer Service Issues',  page: NewReclamationForm(type:type,complaintTypes: ['Problèmes de service client','problèmes de paiement','service quality','Consumer fraud','autre']), context: context),
              alignCard(icon: CupertinoIcons.money_dollar_circle, title: 'Payment problems', page: NewReclamationForm(type:type,complaintTypes: ['problèmes de paiement','Problèmes de service client','service quality','Consumer fraud','autre']), context: context),
              alignCard(icon: Icons.check_circle_outline, title: 'Quality of Service',  page: NewReclamationForm(type:type,complaintTypes: ['service quality','Problèmes de service client','problèmes de paiement','Consumer fraud','autre']), context: context),
              alignCard(icon: Icons.block, title: 'Consumer fraud',  page: NewReclamationForm(type:type,complaintTypes: ['Consumer fraud','Problèmes de service client','problèmes de paiement','service quality','autre']), context: context),
              alignCard(icon: Icons.mark_chat_read_outlined, title: 'Other',  page: NewReclamationForm(type:type,complaintTypes: ['autre','Problèmes de service client','problèmes de paiement','service quality','Consumer fraud',]), context: context),
            ],
          ),
        )
    );
  }
}
