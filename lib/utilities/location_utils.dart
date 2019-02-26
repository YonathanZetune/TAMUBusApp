import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationUtils {
    static Future<LatLng> getDefaultLocation() async {
        var currentLocation;
        var location = Location();

        try {
          currentLocation = await location.getLocation().then((value){
            currentLocation = LatLng((value.values.toList()[2]), (value.values.toList()[3]));
            return currentLocation;
          });

        } catch(e) {
          return LatLng(30.614665, -96.342327);
        }
        return LatLng(30.614665, -96.342327);
    }
}