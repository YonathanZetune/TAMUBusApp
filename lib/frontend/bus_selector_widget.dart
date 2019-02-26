import 'package:flutter/material.dart';
import 'package:tamu_bus_app/requests.dart';
import 'package:tamu_bus_app/frontend/my_home_page.dart';
import 'my_home_page_state.dart';
import 'package:tamu_bus_app/frontend/bus_time_schedule.dart';
// what does this do?? write a sentence about it here
class BusSelectorWidget extends StatelessWidget {
   @override
    Widget build(BuildContext context) {
      print("returning Column in BusSelectorWidget...");
      return Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Slide for more buses...',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          SizedBox(
            // you may want to use an aspect ratio here for tablet support
            height: 80.0,
            child: 
            FutureBuilder(
              future: Requests.getRoutes(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.data == null){
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator()
                    ),
                  );
                } else {
                  return PageView.builder(
                    itemCount: snapshot.data.length,
                    pageSnapping: false,
                    // store this controller in a State to save the carousel scroll position
                    controller: PageController(viewportFraction: .4),
                    itemBuilder: (context, int itemIndex) {
                      return buildCarouselItem(context, itemIndex, snapshot.data[itemIndex].color, snapshot.data[itemIndex].lineNum);
                    },
                    );
                  }
                }
              )
            )
          ],
        );
    }

    // what does this do?? write a sentence about it here
    static Widget buildCarouselItem(BuildContext context, int ind, String col, String busNum) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: FloatingActionButton(
            backgroundColor: Color(int.parse('0x'+col)), // .fromRGBO(128, 0, 0, 1.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            onPressed: (){
                MyHomePage.lastPressed = busNum;
                print('calling getBusMentorsOnRoute in buildCarouselItem...');
                Requests.getBusMentorsOnRoute(busNum).then((buses){
                    MyHomePage.addBusCurrentLocations(context, buses);
                });
                print('calling getLineStops in buildCarouselItem...');
                Requests.getLineStops(busNum).then((stops){
                    MyHomePage.addBusStops(context, stops);
                });
            },
            child: 
            Center(
                child: 
                  FutureBuilder(
                      future: Requests.getRoutes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if (snapshot.data == null){
                        return Container(
                            child: Center(
                                child: CircularProgressIndicator()
                            ),
                        );
                        } else {
                          return 
                            Text(snapshot.data[ind].name + '\n' + snapshot.data[ind].lineNum, textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.white));
                        }
                      }
                  ), 
            ),
        ),
      );
    }
}