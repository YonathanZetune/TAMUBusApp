import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tamu_bus_app/stop.dart';
import 'package:tamu_bus_app/bus_mentor.dart';
import 'package:tamu_bus_app/bus.dart';
import 'package:tamu_bus_app/time_cycle.dart';
import 'package:tamu_bus_app/time_table.dart';

class Requests {

    static Future<List<TimeCycle>> getTimeTable(String line) async{
      var path = "/api/Route/$line/TimeTable";
      var result = await getResult(path);
      var timeCycleList = TimeTable.fromJson(result).timeTable;
      //print(timeCycleList.toString());
      return timeCycleList;
    }

    static Future<List<Bus>> getRoutes() async {
      var path = "/api/Routes";
      var result = await getResult(path);
      var busList = (result).map((i)=>Bus.fromJson(i)).toList();
      return busList;
    }

    static Future<List<Stop>> getLineStops(String line) async {
      var path = "/api/route/$line/stops";
      var result = await getResult(path);
      var lineStopList = (result).map((i)=>Stop.fromJson(i)).toList();
      return lineStopList;
    }

    static Future<List<BusMentor>> getBusMentorsOnRoute(String routeNum) async {
      var path = "/api/route/$routeNum/buses/mentor";
      var result = await getResult(path);
      var busMentorList = result.map((i) => BusMentor.fromJson(i)).toList();
      return busMentorList;
    }

    static Future<List<dynamic>> getResult(String path) async {
        String requestUrl = 'http://transport.tamu.edu/BusRoutesFeed$path';
        var request = await HttpClient().getUrl(Uri.parse(requestUrl)); // produces a request object
        var response = await request.close(); // sends the request
        // transforms and prints the response
        var contents = await response.transform(utf8.decoder).transform(json.decoder).single;{
          return contents;
        }
    }
}

