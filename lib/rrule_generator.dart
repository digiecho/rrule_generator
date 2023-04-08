import 'package:flutter/material.dart';

import 'rrule.dart';
import 'daywheel.dart';
import 'daywheelprefix.dart';

class RRuleGeneratorWidget extends StatefulWidget {
  final RRuleWrapper initialRRule;
  final Function(RRuleWrapper) onRRuleChanged;
  final Color backgroundColor;
  final Color? textColor;

  RRuleGeneratorWidget({
    Key? key,
    required this.initialRRule,
    required this.onRRuleChanged,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  _RRuleGeneratorWidgetState createState() => _RRuleGeneratorWidgetState();
}

class _RRuleGeneratorWidgetState extends State<RRuleGeneratorWidget> {
  late RRuleWrapper _rrule;
  int? _dayWheelPrefixValue = 0;
  int? _dayWheelValue = 0;

  @override
  void initState() {
    super.initState();
    _rrule = widget.initialRRule;
  }

  void _updateRRule() {
    widget.onRRuleChanged(_rrule);
  }

  DropdownButton<String> _customDropDownButton({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      dropdownColor: widget.backgroundColor,
      style: TextStyle(color: widget.textColor),
    );
  }

  Widget _counter({
    required String label,
    required int value,
    required Function() onIncrement,
    required Function() onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: widget.textColor)),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove, color: widget.textColor),
            ),
            Text('$value', style: TextStyle(color: widget.textColor)),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add, color: widget.textColor ?? Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Frequency Dropdown
            Text(_rrule.toRRuleString()),
            _customDropDownButton(
              value: _rrule.frequency,
              items: [
                DropdownMenuItem(
                    value: 'DAILY',
                    child: Text('Daily',
                        style: TextStyle(color: widget.textColor))),
                DropdownMenuItem(
                    value: 'WEEKLY',
                    child: Text('Weekly',
                        style: TextStyle(color: widget.textColor))),
                DropdownMenuItem(
                    value: 'MONTHLY',
                    child: Text('Monthly',
                        style: TextStyle(color: widget.textColor))),
                DropdownMenuItem(
                    value: 'YEARLY',
                    child: Text('Yearly',
                        style: TextStyle(color: widget.textColor))),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _rrule.frequency = newValue!;
                  _updateRRule();
                });
              },
            ),
            // Interval Counter
            Row(
              children: [
                
                _counter(
                  label: 'Repeat Every',
                  value: _rrule.interval ?? 1,
                  onIncrement: () {
                    setState(() {
                      _rrule.interval = (_rrule.interval ?? 0) + 1;
                      _updateRRule();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _rrule.interval = (_rrule.interval ?? 2) - 1;
                      _updateRRule();
                    });
                  },
                ),
              ],
            ),
            // Count Counter
            Row(
              children: [
                _counter(
                  label: 'Repeat For',
                  value: _rrule.count ?? 1,
                  onIncrement: () {
                    setState(() {
                      _rrule.count = (_rrule.count ?? 0) + 1;
                      _updateRRule();
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      _rrule.count = (_rrule.count ?? 2) - 1;
                      _updateRRule();
                    });
                  },
                ),
                Text(_rrule.frequency.toString(), style: TextStyle(color: widget.textColor))
              ],
            ),
            if (_rrule.frequency == 'MONTHLY')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'On the',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: widget.textColor),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Container(
                            width: 150,
                            height: 50,
                            child: DayWheelPrefix(
                              color: widget.backgroundColor,
                              onChanged: (value) {
                                setState(() {
                                  if (value != 0) {
                                    _rrule.bySetPos = value;
                                  } else {
                                    return;
                                  }
                                  _updateRRule();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 65,
                                    height: 40,
                                    child: DayWheel(
                                      color: widget.backgroundColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _dayWheelValue = value;
                                          if (_dayWheelPrefixValue! > 0) {
                                            _rrule.byWeekday = [
                                              '${_dayWheelValue}${_dayWheelPrefixValue}'
                                            ];
                                          } else {
                                            _rrule.byWeekday = [
                                              '${_dayWheelValue}'
                                            ];
                                          }
                                          _updateRRule();
                                        });
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, -0.1),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: widget.textColor,
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            // Until Date Toggle
            Row(
              children: [
                Switch(
                  value: _rrule.until != null,
                  onChanged: (bool value) {
                    setState(() {
                      _rrule.until = value ? DateTime.now() : null;
                      _updateRRule();
                    });
                  },
                ),
                Text('Repeat Until Date', style: TextStyle(color: widget.textColor)),
              ],
            ),
            // Until Date Picker
            if (_rrule.until != null)
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _rrule.until!,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _rrule.until = pickedDate;
                      _updateRRule();
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Until Date: ${_rrule.until!.toIso8601String()}',
                        style: TextStyle(color: widget.textColor)),
                    Icon(Icons.calendar_today, color: widget.textColor),
                  ],
                ),
              ),

            // ByMonthDay Counter
            if (_rrule.frequency == 'MONTHLY')
              Row(
                children: [
                  _counter(
                    label: 'On Day',
                    value: _rrule.byMonthDay ?? 1,
                    onIncrement: () {
                      setState(() {
                        _rrule.byMonthDay = (_rrule.byMonthDay ?? 0) + 1;
                        _updateRRule();
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        _rrule.byMonthDay = (_rrule.byMonthDay ?? 2) - 1;
                        _updateRRule();
                      });
                    },
                  ),
                  Text('of the month', style: TextStyle(color: widget.textColor)),  
                ],
              ),

            // Weekdays
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(
                7,
                (index) {
                  final bool isSelected =
                      _rrule.byWeekday?.contains(index + 1) ?? false;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _rrule.byWeekday?.remove([
                            'MO',
                            'TU',
                            'WE',
                            'TH',
                            'FR',
                            'SA',
                            'SU'
                          ][index]);
                        } else {
                          (_rrule.byWeekday ??= []).add([
                            'MO',
                            'TU',
                            'WE',
                            'TH',
                            'FR',
                            'SA',
                            'SU'
                          ][index]);
                          ;
                        }
                        _updateRRule();
                      });
                    },
                    child: Chip(
                      label: Text(
                        ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][index],
                        style: TextStyle(
                            color:
                                isSelected ? Colors.white : widget.textColor),
                      ),
                      backgroundColor: isSelected
                          ? widget.textColor
                          : widget.backgroundColor,
                    ),
                  );
                },
              ),
            ),

            // Exception Dates
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        (_rrule.exceptionDates ??= []).add(pickedDate);
                        _updateRRule();
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add Exception Date',
                          style: TextStyle(color: widget.textColor)),
                      Icon(Icons.add_circle, color: widget.textColor),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _rrule.exceptionDates?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final DateTime exceptionDate =
                        _rrule.exceptionDates![index];
                    return ListTile(
                      title: Text(exceptionDate.toIso8601String(),
                          style: TextStyle(color: widget.textColor)),
                      trailing: IconButton(
                        icon:
                            Icon(Icons.remove_circle, color: widget.textColor),
                        onPressed: () {
                          setState(() {
                            _rrule.exceptionDates?.removeAt(index);
                            _updateRRule();
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
