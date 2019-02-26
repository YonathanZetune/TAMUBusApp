import 'package:tamu_bus_app/gps_data.dart';

// what does this class do?? write a sentence about it here
class BusMentor {
    String name;
    GPSData gps;
    int passengerData;

    BusMentor(this.name, this.gps, this.passengerData);
    
    factory BusMentor.fromJson(Map<String, dynamic> json) {
      return new BusMentor(
        json["Name"],
        GPSData.fromJson(json["GPS"]),
        json["APC"]["TotalPassenger"]
      );
    }
}