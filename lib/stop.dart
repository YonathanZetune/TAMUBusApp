import 'package:tamu_bus_app/gps_data.dart';

class Stop {
    String name;
    // double latitude;
    // double longitude;
    GPSData location;
    bool isStop;

    Stop(this.name, this.location, this.isStop);
    
    factory Stop.fromJson(Map<String, dynamic> json) {
      return new Stop(
        json["Name"],
        // json["Latitude"],
        // json["Longtitude"],
        new GPSData(null, null, json["Latitude"], json["Longtitude"]),
        json["Stop"]["IsTimePoint"]
      );
    }
}


