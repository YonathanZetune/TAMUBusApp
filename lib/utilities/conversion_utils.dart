import 'dart:math';
import 'dart:core';

class ConversionUtils {

  // converts Web Mercator (102100/3857) X/Y to WGS84 Geographic (Lat/Long) coordinates
  static convertMetToDeg(num lati, num long,){
      // define earth
      final double earthRadius = 6378137.0;
      // handle out of range
      if (max(-lati,lati) < 180 && max(-long,long) < 90)
          return null;
      // this handles the north and south pole nearing infinite Mercator conditions
      if ((max(-lati,lati) > 20037508.3427892) || (max(long,-long) > 20037508.3427892))
          return null;
      // math for conversion
      double num1 = (lati / earthRadius) * 180.0 / pi;
      int num2 = (((num1 + 180.0) ~/ 360.0));//floor
      double num3 = num1 - (num2 * 360.0);
      double num4 = (((pi / 2) - (2.0 * atan(exp((-1.0 * long) / earthRadius)))) * 180 / pi);
      // set the return
      double longitude = num4;
      double lattitude = num3;
      return [longitude,lattitude];
    }
}