import 'package:flutter/material.dart';

class DayWheel extends StatefulWidget {
  final Color color;
  final Function(int) onChanged;

  const DayWheel({Key? key, required this.color, required this.onChanged}) : super(key: key);

  @override
  _DayWheelState createState() => _DayWheelState();
}

class _DayWheelState extends State<DayWheel> {
  final _scrollController = FixedExtentScrollController();

  final List<String> _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      controller: _scrollController,
      physics: const FixedExtentScrollPhysics(),
      itemExtent: 50,
      diameterRatio: 1.8,
      onSelectedItemChanged: (index) {
        widget.onChanged(index + 1);
      },
      children: _weekdays
          .map(
            (weekday) => Container(
              alignment: Alignment.center,
              child: Text(
                weekday,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
