import 'package:basic_rrule_generator/rrule.dart';
import 'package:flutter/material.dart';
import 'package:basic_rrule_generator/rrule_generator.dart';

import 'package:flutter/material.dart';
// Import rrule_generator.dart from your package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Package Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Your Package Example Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RRuleGeneratorWidget(
          initialRRule: RRuleWrapper(frequency: 'DAILY'), // Pass an initial RRuleWrapper instance
          onRRuleChanged: (RRuleWrapper rrule) {
            // Handle RRule changes
          },
        ),
      ),
    );
  }
}

