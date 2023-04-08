import 'package:flutter_test/flutter_test.dart';

import 'package:rrule_generator/rrule_generator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rrule_generator/RRule.dart';


void main() {
  testWidgets('RRuleGeneratorWidget renders correctly', (WidgetTester tester) async {
    // Initialize an RRuleWrapper object
    RRuleWrapper rrule = RRuleWrapper(
      frequency: 'DAILY',
      interval: 1,
      count: null,
      until: null,
      byWeekday: [],
      byMonthDay: [],
      byMonth: [],
      exceptionDates: [],
    );

    // Build the RRuleGeneratorWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RRuleGeneratorWidget(
            initialRRule: rrule,
            onRRuleChanged: (RRuleWrapper newRRule) {
              // Handle the RRule change here
            },
          ),
        ),
      ),
    );

    // Check if the RRuleGeneratorWidget is displayed
    expect(find.byType(RRuleGeneratorWidget), findsOneWidget);

    // Check if the initial RRule is displayed correctly
    expect(find.text('Daily'), findsOneWidget);
  });
}
