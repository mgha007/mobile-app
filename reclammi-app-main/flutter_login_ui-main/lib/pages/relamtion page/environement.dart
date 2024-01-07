import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';

import '../new_reclamation.dart';
import '../widgets/widgets.dart';

class environement extends StatefulWidget {
  const environement({Key? key}): super(key:key);

  @override
  State<environement> createState() => _environementState();
}

class _environementState extends State<environement> {
  String type="environement";
  final List<String> complaintTypes = ['Type 1', 'Type 2', 'Type 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('environement'),
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
              alignCard(icon: CupertinoIcons.waveform_path_ecg, title: 'Aire pollution',  page: NewReclamationForm(type:type,complaintTypes: ['Aire pollition''Pollution des sols','Feu','Pollution sonore''autre']), context: context),
              alignCard(icon: CupertinoIcons.rectangle_paperclip, title: 'Pollution des sols',  page: NewReclamationForm(type:type,complaintTypes: ['Pollution des sols','Aire pollition','Feu','Pollution sonore','autre']), context: context),
              alignCard(icon: CupertinoIcons.flame, title: 'Feu',  page: NewReclamationForm(type:type,complaintTypes: ['Feu','Pollution des sols','Aire pollition','Pollution sonore','autre']), context: context),
              alignCard(icon: Icons.volume_up, title: 'Pollution sonore',  page: NewReclamationForm(type:type,complaintTypes: ['Pollution sonore','Feu','Pollution des sols','Aire pollition','autre']), context: context),
              alignCard(icon: Icons.mark_chat_read_outlined, title: 'autre',  page: NewReclamationForm(type:type,complaintTypes: ['autre','Pollution des sols','Aire pollition','Pollution sonore','Feu',]), context: context),
            ],
          ),
        )
    );
  }
}
