import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/pdf_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'ComplaintListt.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart'as http;
import 'config.dart';
import 'profil.dart';
import 'profile_page.dart';


class admin extends StatefulWidget {
  final  complaint;
  final  id ;
  admin({required this.complaint,required this.id});
  String get token => globals.authToken;

  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  final TextEditingController  _commentController = TextEditingController();
  final  TextEditingController  _adminreponseController = TextEditingController();

  late String? userID;
  @override
  void initState() {
    super.initState();
    setState(() {
      Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
      userID=jwtDecodedToken['_id'];
    });
  }

  void addresp() async {
    if (_adminreponseController.text.isNotEmpty) {
      var reqBody = {
        "response": _adminreponseController.text,
        "complaintId": widget.id,

      };

      var response = await http.put(
        Uri.parse(addres),
        headers: {"content-type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Comment added successfully');
        print(jsonResponse['success']);
        setState(() {
          widget.complaint['adminresponse']=jsonResponse['success']['adminresponse'];
          _adminreponseController.clear();
        });

      } else {
        print('Failed to add comment');
      }
    }
  }
  void addfeed() async {
    if (_commentController.text.isNotEmpty) {
      var reqBody = {
        "comment": _commentController.text,
        "complaintId": widget.id,
        "submitter": userID,
      };

      var response = await http.put(
        Uri.parse(addComment),
        headers: {"content-type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Comment added successfully');
        print(jsonResponse['success']);

        setState(() {
          // Add the new comment to the existing comments list
          widget.complaint['comments']=jsonResponse['success']['comments'];
        });
        _commentController.clear();
      } else {
        print('Failed to add comment');
      }
    }
  }

  void changeState(String newStatus) async {
    if (newStatus.isNotEmpty) {
      var reqBody = {
        "status": newStatus,
        "complaintId": widget.id,
      };

      var response = await http.put(
        Uri.parse(changeS),
        headers: {"content-type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Status changed successfully');
        print(jsonResponse['success']);

        setState(() {
          widget.complaint['status'] = jsonResponse['success']['status'];
        });
      } else {
        print('Failed to change status');
      }
    }
  }
  void deleteComplaint() async {

      var reqBody = {
        "complaintId": widget.id,
      };

      var response = await http.delete(
        Uri.parse(deletec),
        headers: {"content-type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Complaint deleted successfully');
        print(jsonResponse['true']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => toutlespost()),
        );

        // Perform any necessary UI updates or navigation here
      } else {
        print('Failed to delete complaint');
      }

  }

  void deleteComment(String idCom) async {

    var reqBody = {
      "complaintId": widget.id,
      "commentId":idCom
    };

    var response = await http.put(
      Uri.parse(deletecom),
      headers: {"content-type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print(idCom);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('Complaint deleted successfully');
      print(jsonResponse['true']);
   setState(() {
     widget.complaint['comments']=jsonResponse['success']['comments'];
   });

      // Perform any necessary UI updates or navigation here
    } else {
      print('Failed to delete comment');
    }

  }



  @override
  String _adminreponsee = '';
  String selectedOption ='';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text(widget.complaint['title']?? ''),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteComplaint();
            },
          ),
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pdfpage(complaint:widget.complaint,)),);
            },
          ),
        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Soummet par:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => profil(id: widget.complaint['submitter']['_id'],)),
                            );
                          },
                          child: CircleAvatar(
                            child: IconButton(
                              icon: Icon(Icons.person),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => profil(id: widget.complaint['submitter']['_id'],)),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '${widget.complaint['submitter']['firstName'] ?? ''} ${widget.complaint['submitter']['lastName'] ?? ''}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height:10.0),
                    Text(
                      'Titre:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.complaint['title']?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Type:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${widget.complaint['type']['type'] ?? ''} ${widget.complaint['type']['soustype'] ?? ''}',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.complaint['description']?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Statu:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButton<String>(
                      value: widget.complaint['status'],
                      onChanged: (String? value) {
                        setState(() {
                          widget.complaint['status'] = value!;
                          changeState(value); // Call the changeState function with the selected value
                        });
                      },
                      items: [
                        'resolved',
                        'inProgress',
                        'pending',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                value == 'resolved'
                                    ? Icons.check_circle
                                    : value == 'inProgress'
                                    ? Icons.info
                                    : Icons.access_time,
                                color: value == 'resolved'
                                    ? Colors.green
                                    : value == 'inProgress'
                                    ? Colors.amber
                                    : Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                value,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: value == 'resolved'
                                      ? Colors.green
                                      : value == 'inProgress'
                                      ? Colors.amber
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    if (widget.complaint['file'].isNotEmpty)
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.complaint['file'],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
        if (widget.complaint['adminresponse'] != null)
       Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  ),
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Response:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.complaint['adminresponse'] ?? '',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
     if(widget.complaint['adminresponse'] == null)
     Column(
    children: [
    SizedBox(height: 10),
    Text(
    'Entrer la réponse à cette réclamation:',
    style: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    ),
    ),
    SizedBox(height: 16.0),
    TextFormField(
    decoration: InputDecoration(
    hintText: 'Complaint responce',
    hintStyle: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    ),
    border: OutlineInputBorder(),
    ),
    maxLines: 5,
    controller: _adminreponseController,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a description';
    }
    return null;
    },
    onSaved: (value) {
    _adminreponsee = value!;
    },
    ),
    SizedBox(height: 10),
    ElevatedButton(
    onPressed: () {
    addresp();
    setState(() {});
    },
    child: Text(
    'Envoyer votre réponse',
    style: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    ),
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.blue,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    textStyle: TextStyle(color: Colors.white),
    ),
    ),
    ],
    ),



                    SizedBox(height: 16.0),
                    Text(
                      'Commentaire:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.complaint['comments']?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {}),
                            children: [
                              SlidableAction(
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                                onPressed: (BuildContext context) {
                                  deleteComment(widget.complaint?['comments'][index]?['_id']);
                                },
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => profil(id: widget.complaint['comments'][index]?['submitter']['_id'],)),
                                );
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            title: Text('${widget.complaint['comments'][index]?['submitter']?['firstName'] ?? ''} ${widget.complaint['comments'][index]?['submitter']?['lastName'] ?? ''}'),
                            subtitle: Text(
                              '${widget.complaint?['comments'][index]?['comment'] ??''} ',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            addfeed();
                          },
                          child: Text('Add'),
                        )],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
