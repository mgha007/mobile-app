
import 'dart:math';

import 'package:flutter/material.dart';
class Statistique extends StatefulWidget {
  @override
  _StatistiqueState createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  int numReponses = 50;
  int numNonReponses = 20;
  int numReclamationsVues = 30;

  // Define a list of example cities with their corresponding number of complaints
  List<Map<String, dynamic>> cityComplaints = [    {"name": "Paris", "numComplaints": 20},    {"name": "Lyon", "numComplaints": 10},    {"name": "Marseille", "numComplaints": 30},    {"name": "Toulouse", "numComplaints": 5},  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Statistics"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
        // Add a circle in the center of the pie chart
        Positioned.fill(
        child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ),
    // Add the pie chart
    Positioned.fill(
    child: CustomPaint(
    painter: _PieChartPainter(
    color: Colors.green,
    value: numReponses / (numReponses + numNonReponses + numReclamationsVues),
    ),
    ),
    ),
    Positioned.fill(
    child: CustomPaint(
    painter: _PieChartPainter(
    color: Colors.red,
    value: numNonReponses / (numReponses + numNonReponses + numReclamationsVues),
    startAngle: numReponses / (numReponses + numNonReponses + numReclamationsVues) * 2 * pi,
    ),
    ),
    ),
    Positioned.fill(
    child: CustomPaint(
    painter: _PieChartPainter(
    color: Colors.orange,
    value: numReclamationsVues / (numReponses + numNonReponses + numReclamationsVues),
    startAngle: (numReponses + numNonReponses + numReclamationsVues) / (numReponses + numNonReponses + numReclamationsVues) * 2 * pi,
    ),
    ),
    ),
    // Add the text widgets below the pie chart
    Positioned(
    left: 0,
    right: 0,
    top: 120,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    // Display the title of the bar chart
    Text("Number of complaints per city:", style: TextStyle(fontSize: 18),),
    SizedBox(height: 10),
    // Display the bar chart
    Expanded(
    child: ListView.builder(
    itemCount: cityComplaints.length,
    itemBuilder: (BuildContext context, int index) {
    return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    height: 50,
    child: Stack(
    children: [
    // Add a blue bar for each city


// Add a blue bar for each city
      Container(
        width: cityComplaints[index]["numComplaints"] * 5,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
// Add the name of the city on top of the blue bar
      Positioned.fill(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(cityComplaints[index]["name"], style: TextStyle(fontSize: 16),),
          ),
        ),
      ),
// Add the number of complaints on top of the blue bar
      Positioned.fill(
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text("${cityComplaints[index]["numComplaints"]}", style: TextStyle(fontSize: 16),),
          ),
        ),
      ),
    ],
    ),
    );
    },
    ),
    ),
    ],
    ),
    ),
          ],
        ),
      ),
    );
  }
}


class _PieChartPainter extends CustomPainter {
  final Color color;
  final double value;
  final double startAngle;

  _PieChartPainter({required this.color, required this.value, this.startAngle = 0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 2;
    canvas.drawArc(Offset.zero & size, startAngle, value * 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



