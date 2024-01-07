import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/pdf_page.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart'as http;
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'profil.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  final  complaint;
  final  id ;
  ComplaintDetailsScreen({required this.complaint,required this.id});
  String get token => globals.authToken;

  @override
  _ComplaintDetailsScreenState createState() => _ComplaintDetailsScreenState();
}
class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  late String? userID;
  @override
  void initState() {
    super.initState();
    setState(() {
      Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
      userID=jwtDecodedToken['_id'];
    });
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

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text(widget.complaint['title']?? ''),
        actions: [
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Submitted by:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
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
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Titre:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.complaint['title']?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Type:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${widget.complaint['type']['type'] ?? ''} ${widget.complaint['type']['soustype'] ?? ''}',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Description:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.complaint['description']?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 20.0),

                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color:Colors.grey.shade300)),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Status:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(
                          widget.complaint['status'] == 'resolved'
                              ? Icons.check_circle
                              : widget.complaint['status'] == 'inProgress'
                              ? Icons.info
                              : Icons.access_time,
                          color: widget.complaint['status'] == 'resolved'
                              ? Colors.green
                              : widget.complaint['status'] == 'inProgress'
                              ? Colors.amber
                              : Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.complaint['status'].toString().toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.complaint['status'] == 'resolved'
                                ? Colors.green
                                : widget.complaint['status'] == 'inProgress'
                                ? Colors.amber
                                : Colors.red,
                          ),
                        ),
                      ],
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

                    if (widget.complaint['adminresponse'] != null)
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
                                'response:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.complaint['adminresponse']?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 30),
                    Text(
                      'Comments:',
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
                        return ListTile(
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
