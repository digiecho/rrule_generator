import 'package:flutter/material.dart';

class DayWheelPrefix extends StatefulWidget {
  final Color? color;
  final Function(int?) onChanged;

  const DayWheelPrefix({Key? key, this.color, required this.onChanged}) : super(key: key);

  @override
  _DayWheelPrefixState createState() => _DayWheelPrefixState();
}

class _DayWheelPrefixState extends State<DayWheelPrefix> {
  final _scrollController = FixedExtentScrollController();

  final List<String> _prefixes = [
    'Pick',
    'First',
    'Second',
    'Third',
    'Fourth',
    'Last',
    'Second From last',
  ];

 final List<int?> _itemsValue = [
   0,1,2,3,4,-1,-2
  ];

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      controller: _scrollController,
      physics: const FixedExtentScrollPhysics(),
      itemExtent: 50,
      diameterRatio: 1.8,
      onSelectedItemChanged: (index) {
        int? prefix = index == 0 ? null : _itemsValue[index];
        widget.onChanged(prefix);
      },
      children: _prefixes
          .map(
            (prefix) => Container(
              alignment: Alignment.center,
              child: Text(
                prefix,
                style: const TextStyle(
                  color: Colors.black,
                  
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
