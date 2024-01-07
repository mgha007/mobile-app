import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';



class ComplaintPopup extends StatelessWidget {
  final String title;
  final String description;
  // final FileData? fileData;

  ComplaintPopup({
    required this.title,
    required this.description,
    // this.fileData,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          // if (fileData != null) ...[
          //   SizedBox(height: 10.0),
          //   Text(
          //     'File:',
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   SizedBox(height: 5.0),
          //   // _buildFileWidget(fileData!),
          // ],
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('fermer'),
        ),
      ],
    );
  }

  // Widget _buildFileWidget(FileData fileData) {
  //   switch (fileData.fileType) {
  //     case FileType.Image:
  //       return Image.network(
  //         fileData.fileUrl,
  //         fit: BoxFit.cover,
  //       );
  //     case FileType.Video:
  //       return AspectRatio(
  //         aspectRatio: 16 / 9,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(8.0),
  //             color: Colors.grey[300],
  //           ),
  //           child: Icon(Icons.play_arrow),
  //         ),
  //       );
  //     case FileType.Document:
  //       return Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8.0),
  //           color: Colors.grey[300],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(Icons.insert_drive_file),
  //               SizedBox(width: 5.0),
  //               Text(fileData.filename),
  //             ],
  //           ),
  //         ),
  //       );
  //   }
  // }
}
