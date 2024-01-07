import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';

import '../new_reclamation.dart';
import '../widgets/widgets.dart';

class electricity extends StatefulWidget {
  const electricity({Key? key}): super(key:key);

  @override
  State<electricity> createState() => _electricityState();
}

class _electricityState extends State<electricity> {
  String type="électricité";
  final List<String> complaintTypes = ['Type 1', 'Type 2', 'Type 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('électricité'),
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
             alignCard(icon: CupertinoIcons.train_style_one, title: 'Service Clients',  page: NewReclamationForm(type:type,complaintTypes: ['Service Clients','autre','problèmes de paiement','pannes Interruptions de service']), context: context),
             alignCard(icon: CupertinoIcons.train_style_one, title: 'problèmes de paiement',  page: NewReclamationForm(type:type,complaintTypes: ['problèmes de paiement','autre','Service Clients','pannes Interruptions de service']), context: context),
             alignCard(icon: CupertinoIcons.train_style_one, title: 'Interruptions de service',  page: NewReclamationForm(type:type,complaintTypes: ['pannes Interruptions de service','autre','Service Clients','problèmes de paiement']), context: context),
             alignCard(icon: CupertinoIcons.train_style_one, title: 'autre',  page: NewReclamationForm(type:type,complaintTypes: ['autre','Service Clients','problèmes de paiement','pannes Interruptions de service']), context: context),


           ],
          ),
        )
    );
  }
}
