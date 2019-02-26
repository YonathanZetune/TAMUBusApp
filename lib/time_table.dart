import 'package:tamu_bus_app/time_cycle.dart';

class TimeTable {
  final List<TimeCycle> timeTable;

  TimeTable(this.timeTable);

  factory TimeTable.fromJson(List<dynamic> parsedJson) {
    List<TimeCycle> timeCycles = (parsedJson).map((i)=>TimeCycle.fromJson(i)).toList();
    return new TimeTable(timeCycles);
  }
}

