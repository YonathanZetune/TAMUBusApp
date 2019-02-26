import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tamu_bus_app/frontend/bus_selector_widget.dart';
import 'package:tamu_bus_app/requests.dart';
import 'package:tamu_bus_app/frontend/my_home_page.dart';
import 'package:tamu_bus_app/frontend/bus_time_schedule.dart';
import 'package:tamu_bus_app/utilities/location_utils.dart';
import 'bus_time_schedule.dart';

class MyHomePageState extends State<MyHomePage> {
  static GoogleMapController myController;
  static LatLng currentLoc;
  static HomeTable myTable = new HomeTable();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.info), onPressed: (){
                        showAboutDialog(context: context,applicationName: 'TAMU Spirit',applicationVersion: '1.1.0',
                        children: <Widget>[Text('\tThank you for using TAMU Spirit! \n\tThis app automatically refreshes every 15 seconds' 
                        ' depending on the last pressed bus route. If no route is selected, route 01 is automatically loaded.'
                        ' Data is not guaranteed to be accurate.\n\t For any questions, comments or suggestions, click the "App Page" button below.\n\t'
                        ' Thanks and Gig '"'em!"
                        '\nYonathan Zetune\nClass of '"'22",style: TextStyle(fontSize: 16,color: Colors.black),),
                        Padding(padding: EdgeInsets.all(30),),
                        FlatButton(child: Text('APP PAGE',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),),
                        onPressed: (){
                            _launchURL();
                        },)
                        ],);
                    }),

            actions: <Widget>[IconButton(icon: Icon(Icons.home), onPressed: (){
                setState(() {
                    moveToCurrentLocation();
                });
            }),
            
            ],
            backgroundColor: Color.fromRGBO(128, 0, 0, 1.0),
            title: Text("TAMU Spirit"),
        ),
       // This trailing comma makes auto-formatting nicer for build methods.
       body: Stack(
           alignment: AlignmentDirectional.bottomStart,
           children: <Widget>[    
               Container(
                   height: MediaQuery.of(context).size.height - 0,
                   width: MediaQuery.of(context).size.width,
                   child: GoogleMap(
                       onMapCreated: (controller) {
                           setState(() {
                            myController = controller;            
                           });
                       },
                       options: GoogleMapOptions(
                           myLocationEnabled: true,
                           mapType: MapType.normal,
                           zoomGesturesEnabled: true,
                           rotateGesturesEnabled: true,
                           tiltGesturesEnabled: false,
                           scrollGesturesEnabled: true,
                           cameraPosition: CameraPosition(
                               target: LatLng(30.614665, -96.342327),
                               bearing: 270,
                               zoom: 13.0,
                               tilt: 0
                           )
                       ),
                   ),
               ),
               Positioned(
                   child:
               Container(
                   child: FloatingActionButton(
                       onPressed: null
                   ),

               ),
               ),
               Positioned(
                   child:
               Container(
                   child: myTable
               ),
               ),
               BusSelectorWidget(),
           ],
       ),
    );
  }
  _launchURL() async {
  const url = 'https://www.facebook.com/tamubusapp/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
  }
  void updateState() {
    setState(() {
              myTable = HomeTable();
            });
  }
//     static void updateBusTimeTable(){
//       updateState();
//   }

  void moveToCurrentLocation() async {
      int count = 0;
      while((myController != null) && (count == 0)) {
      currentLoc = await LocationUtils.getDefaultLocation();
      myController.moveCamera(CameraUpdate.newLatLng(currentLoc));
      count++;
      }
  }
 
  @override
void initState() {
    super.initState();
    
    moveToCurrentLocation();
    const fifSec = const Duration(seconds:15);
    new Timer.periodic(fifSec, (Timer t) { 
        Requests.getBusMentorsOnRoute(MyHomePage.lastPressed).then((buses){
            MyHomePage.addBusCurrentLocations(context, buses);
        });
        Requests.getLineStops(MyHomePage.lastPressed).then((stops){
            MyHomePage.addBusStops(context, stops);

        });
        }
    );
     
  }
}