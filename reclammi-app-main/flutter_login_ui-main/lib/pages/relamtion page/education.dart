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
  String type="Education";
  final List<String> complaintTypes = ['professor '];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 4,
          title: Text('Education'),
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
              alignCard(icon: CupertinoIcons.t_bubble, title: 'Quality of education', page: NewReclamationForm(type:type,complaintTypes: ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: CupertinoIcons.bandage, title: 'discrimination and harassment',  page: NewReclamationForm(type:type,complaintTypes:['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: CupertinoIcons.bag_badge_minus, title: 'Security',  page: NewReclamationForm(type:type,complaintTypes: ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: CupertinoIcons.add_circled, title: 'Access and accommodation',  page: NewReclamationForm(type:type,complaintTypes: ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),
              alignCard(icon: Icons.mark_chat_read_outlined, title: 'Other', page: NewReclamationForm(type:type,complaintTypes:  ['Quality of education','discrimination et harcèlement','sécurité','Accès et hébergement','Conformité réglementaire'],), context: context),

            ],
          ),
        )
    );
  }
}
