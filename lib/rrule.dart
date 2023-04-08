class RRuleWrapper {
  String frequency;
  int? interval;
  int? count;
  DateTime? until;
  List<String>? byWeekday;
  int? byMonthDay;
  int? byMonth;
  int? bySetPos;
  List<DateTime>? exceptionDates;

  RRuleWrapper({
    required this.frequency,
    this.interval,
    this.count,
    this.until,
    this.byWeekday,
    this.byMonthDay,
    this.byMonth,
    this.bySetPos,
    this.exceptionDates,
  });

  String toRRuleString() {
    List<String> rruleParts = ['FREQ=$frequency'];

    if (interval != null) {
      rruleParts.add('INTERVAL=$interval');
    }

    if (count != null) {
      rruleParts.add('COUNT=$count');
    }

    if (until != null) {
      rruleParts.add('UNTIL=${until!.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}');
    }

    if (byWeekday != null && byWeekday!.isNotEmpty) {
      rruleParts.add('BYDAY=${byWeekday!.join(",")}');
    }

    if (byMonthDay != null) {
      rruleParts.add('BYMONTHDAY=$byMonthDay');
    }

    if (byMonth != null) {
      rruleParts.add('BYMONTH=$byMonth');
    }

    if (bySetPos != null) {
      rruleParts.add('BYSETPOS=$bySetPos');
    }

    String rruleString = rruleParts.join(";");

    if (exceptionDates != null && exceptionDates!.isNotEmpty) {
      String exDates = exceptionDates!.map((date) => date.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]).join(",");
      rruleString += '\nEXDATE=$exDates';
    }

    return rruleString;
  }
}
