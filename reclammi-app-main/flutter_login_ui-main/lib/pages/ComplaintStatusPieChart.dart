import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'botonchart.dart';
import 'config.dart';
import 'linechart.dart';

class ComplaintStatusPieChart extends StatefulWidget {
  const ComplaintStatusPieChart({Key? key}) : super(key: key);

  @override
  _ComplaintStatusPieChartState createState() =>
      _ComplaintStatusPieChartState();
}

class _ComplaintStatusPieChartState extends State<ComplaintStatusPieChart> {
  List complaints = [];
  List pending = [];
  List resolved = [];
  List inprogress = [];

  @override
  void initState() {
    super.initState();
    all();
    p();
    r();
    i();
  }

  void all() async {
    var response = await http.get(Uri.parse(All));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        complaints = jsonResponse['success'] ?? [];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void p() async {
    var response = await http.get(Uri.parse(pe));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        pending = jsonResponse['success'] ?? [];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void r() async {
    var response = await http.get(Uri.parse(re));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        resolved = jsonResponse['success'] ?? [];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void i() async {
    var response = await http.get(Uri.parse(ing));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        inprogress = jsonResponse['success'] ?? [];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text('statistics'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          SizedBox(
            height: 9,
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Statistics on the number of complaints by status :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      statCard(
                          icon: Icons.warning,
                          title: 'Reclamation on progress',
                          subtitle:
                          'The number of complaints in progress is ',
                          nombrereclam: inprogress.length,
                          color: Colors.orange),
                      SizedBox(
                        width: 7,
                      ),
                      statCard(
                          icon: Icons.check_circle,
                          title: 'recamation resolved',
                          subtitle:
                          'The number of complaints resolved is ',
                          nombrereclam: resolved.length,
                          color: Colors.green),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      statCard(
                          icon: Icons.close_rounded,
                          title: 'Pending complaints',
                          subtitle:
                          'The number of rejected claims is ',
                          nombrereclam: pending.length,
                          color: Colors.red),
                      SizedBox(
                        width: 7,
                      ),
                      statCard(
                          icon: Icons.book,
                          title: 'All complaints',
                          subtitle: 'The total number of complaints',
                          nombrereclam: complaints.length,
                          color: Colors.blue),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Statistics on the number of complaints by category: ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Barchart(),
          ),

        ]),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final Map<String, int> complaintStatusCounts = {};
    complaintStatusCounts['pending'] = 0;
    complaintStatusCounts['inProgress'] = 0;
    complaintStatusCounts['resolved'] = 0;

    // Count the number of complaints with each status
    complaints.forEach((complaint) {
      complaintStatusCounts[complaint['status']] =
          (complaintStatusCounts[complaint['status']] ?? 0) + 1;
    });

    // Calculate the total number of complaints
    int totalComplaints =
    complaintStatusCounts.values.reduce((a, b) => a + b);
    return complaintStatusCounts.keys.map((status) {
      final isTouched =
          complaintStatusCounts.keys.toList().indexOf(status) == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: getStatusColor(status)!,
        value: complaintStatusCounts[status]!.toDouble(),
        title:
        '${((complaintStatusCounts[status]! / totalComplaints) * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          getStatusIcon(status)!,
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }

  Color? getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.red;
      case 'resolved':
        return Colors.green;
      case 'inProgress':
        return Colors.orange;
      default:
        return null;
    }
  }

  String? getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return 'assets/pending.svg';
      case 'resolved':
        return 'assets/resolved.svg';
      case 'inProgress':
        return 'assets/in_progress.svg';
      default:
        return null;
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
      this.svgAsset, {
        required this.size,
        required this.borderColor,
      });
  final String? svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            svgAsset!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

