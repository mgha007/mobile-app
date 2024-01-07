import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class BarChartModel {
  final String categorie;
  final num financial;
  final charts.Color color;

  BarChartModel({
    required this.categorie,
    required this.financial,
    required this.color,
  });
}

class Barchart extends StatefulWidget {
  @override
  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  List? education;
  List? consumer;
  List? elec;
  List? envi;
  List? medical;
  List? trans;
  List? water;
  List? autre;

  List<BarChartModel> data = [];

  @override
  void initState() {
    super.initState();
    educa();
    affere();
    elce();
    envir();
    medi();
    trss();
    wa();
    aut();
  }

  void educa() async {
    var response = await http.get(Uri.parse(educ));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        education = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void affere() async {
    var response = await http.get(Uri.parse(affer));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        consumer = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void elce() async {
    var response = await http.get(Uri.parse(elc));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        elec = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void envir() async {
    var response = await http.get(Uri.parse(env));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        envi = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void medi() async {
    var response = await http.get(Uri.parse(med));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        medical = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void trss() async {
    var response = await http.get(Uri.parse(trs));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        trans = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void wa() async {
    var response = await http.get(Uri.parse(wat));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        water = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void aut() async {
    var response = await http.get(Uri.parse(at));

    print('Response status code: ${response.statusCode}');
    print('Response status message: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      try {
        autre = jsonResponse['success'];
      } catch (error) {
        print("Error: $error");
        // Handle the error as needed
      }
      setState(() {
        updateChartData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void updateChartData() {
    data = [
      BarChartModel(
        categorie: "educ",
        financial: education?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
      ),
      BarChartModel(
        categorie: "cons",
        financial: consumer?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      BarChartModel(
        categorie: "elect",
        financial: elec?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      BarChartModel(
        categorie: "envi",
        financial: envi?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      ),
      BarChartModel(
        categorie: "med",
        financial: medical?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
      ),
      BarChartModel(
        categorie: "trans",
        financial: trans?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.pink),
      ),
      BarChartModel(
        categorie: "eau",
        financial: water?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.purple),
      ),
      BarChartModel(
        categorie: "autre",
        financial: autre?.length ?? 0,
        color: charts.ColorUtil.fromDartColor(Colors.purple),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (BarChartModel series, _) => series.categorie,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: charts.BarChart(
        series,
        animate: true,
      ),
    );
  }
}
