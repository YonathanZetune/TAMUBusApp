import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tamu_bus_app/bus_mentor.dart';
import 'package:tamu_bus_app/utilities/conversion_utils.dart';
import 'package:tamu_bus_app/stop.dart';
import 'package:tamu_bus_app/frontend/my_home_page_state.dart';
import 'package:tamu_bus_app/frontend/bus_time_schedule.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  static String lastPressed = '01';
  final String title;
  //static HomeTable _myTab = new HomeTable();
 
  static Widget getRouteTitle() {
      return Text(lastPressed, style: TextStyle(color: Colors.white,fontSize: 30));
  }
   void updateTable(){
      
  }
  static void addBusCurrentLocations(BuildContext context, List<BusMentor> lineBuses) {
    
    MyHomePageState.myController.clearMarkers();
    
     for(BusMentor bus in lineBuses){
      MyHomePageState.myController.addMarker(MarkerOptions(
        rotation: bus.gps.direction - 120,
        flat: true,
        infoWindowText: InfoWindowText('Bus: ' + bus.name, bus.passengerData.toString() + ' passengers'),
        icon: BitmapDescriptor.fromAsset("assets/iconbus.png"),
        position:
        LatLng((ConversionUtils.convertMetToDeg(bus.gps.longitude, bus.gps.latitude))[0], ConversionUtils.convertMetToDeg(bus.gps.longitude,bus.gps.latitude)[1])));
    }
  }
  static void addBusStops(BuildContext context, List<Stop> lineStops) {

     for(Stop stop in lineStops){
         
         BitmapDescriptor myIcon = BitmapDescriptor.fromAsset("assets/stop.png");
         String stopType = 'Stop Point';
         if(!stop.isStop){
             stopType = 'Way Point';
             myIcon = BitmapDescriptor.fromAsset("assets/flag.png");
         }
      MyHomePageState.myController.addMarker(MarkerOptions(
          flat: false,
        infoWindowText: InfoWindowText('Stop: ' + stop.name, stopType),
        icon: myIcon,
        position:
        LatLng((ConversionUtils.convertMetToDeg(stop.location.longitude, stop.location.latitude))[0], ConversionUtils.convertMetToDeg(stop.location.longitude,stop.location.latitude)[1])));
    }
  }

  @override
  MyHomePageState createState() => MyHomePageState();
}