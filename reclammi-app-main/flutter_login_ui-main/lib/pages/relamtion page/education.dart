import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';

import '../new_reclamation.dart';
import '../widgets/widgets.dart';

class education extends StatefulWidget {
  const education({Key? key}): super(key:key);

  @override
  State<education> createState() => _educationState();
}

class _educationState extends State<education> {
  String type="education";
  final List<String> complaintTypes = ['prof '];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('education'),
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
              alignCard(icon: CupertinoIcons.t_bubble, title: 'Qualité de léducation', page: NewReclamationForm(type:type,complaintTypes: ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: CupertinoIcons.bandage, title: 'discrimination et harcèlement',  page: NewReclamationForm(type:type,complaintTypes:['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: CupertinoIcons.bag_badge_minus, title: 'sécurité',  page: NewReclamationForm(type:type,complaintTypes: ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: CupertinoIcons.add_circled, title: 'Accès et hébergement',  page: NewReclamationForm(type:type,complaintTypes: ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: Icons.mark_chat_read_outlined, title: 'Autre', page: NewReclamationForm(type:type,complaintTypes:  ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),

            ],
          ),
        )
    );
  }
}
