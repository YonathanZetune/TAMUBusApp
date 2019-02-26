import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:tamu_bus_app/time_cycle.dart';
import 'package:tamu_bus_app/requests.dart';
import 'my_home_page.dart';

class HomeTable extends StatelessWidget{
HomeTable({Key key}) : super(key: key);

static Table myTimeTable = new Table(children: [TableRow(children: [Text('No Data')])]);
    @override
    Widget build(BuildContext context){

        return FutureBuilder(
            future: Requests.getTimeTable(MyHomePage.lastPressed),
            builder:  (BuildContext context, AsyncSnapshot snapshot){
                    if (snapshot.data == null){
                        return myTimeTable;
                    } else {
                        myTimeTable = Table(children: getStopNames(snapshot.data));                        
                    return myTimeTable;
                }
            });
            

    }
 static List<TableRow> getStopNames(List<TimeCycle> data){
    List<TableRow> myRet = new List<TableRow>();
    TableRow names = new TableRow(
        children: [Text('')]
    );
    for(TimeCycle cycle in data){
        
        names.children.clear();
        for(String time in cycle.time){
        names.children.add(Text(time.toString()));
        }
        myRet.add(names);
        
    }
    return myRet;
}


}