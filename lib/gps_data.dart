class GPSData {
    String date;
    double direction;
    double latitude;
    double longitude;

    GPSData(this.date, this.direction, this.latitude, this.longitude);
    
    factory GPSData.fromJson(Map<String, dynamic> json) {
      return new GPSData(
        json["Date"],
        json["Dir"],
        json["Lat"],
        json["Long"]
      );
  }
}