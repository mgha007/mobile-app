import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';

import '../new_reclamation.dart';
import '../widgets/widgets.dart';

class transport extends StatefulWidget {
  const transport({Key? key}): super(key:key);

  @override
  State<transport> createState() => _transportState();
}

class _transportState extends State<transport> {
  String type ="transport";
  final List<String> complaintTypes = ['Type 1', 'Type 2', 'Type 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('transport'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/street.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
           children: [
             alignCard(icon: Icons.monetization_on_outlined, title: 'Problèmes de tarifs ',  page: NewReclamationForm(type:type,complaintTypes: ['Problèmes de tarifs ','Accessibilité','Qualité de service','Problèmes de sécurité','autre']), context: context),
             alignCard(icon: CupertinoIcons.lock, title: 'Accessibilité',  page: NewReclamationForm(type:type,complaintTypes:['Accessibilité','Problèmes de tarifs ','Qualité de service','Problèmes de sécurité','autre']), context: context),
             alignCard(icon: Icons.info, title: 'Qualité de service',  page: NewReclamationForm(type:type,complaintTypes: ['Qualité de service','Problèmes de tarifs ','Accessibilité','Problèmes de sécurité','autre']), context: context),
             alignCard(icon: Icons.back_hand_outlined, title: 'Problèmes de sécurité',  page: NewReclamationForm(type:type,complaintTypes: ['Problèmes de sécurité','Problèmes de tarifs','Accessibilité','Qualité de service','autre']), context: context),
             alignCard(icon: Icons.mark_chat_read_outlined, title: 'autre',  page: NewReclamationForm(type:type,complaintTypes:['autre','Problèmes de tarifs ','Accessibilité','Qualité de service','Problèmes de sécurité',]), context: context),
           ],
          ),
        )
    );
  }
}
