class TimeCycle {

    List<String> names;
    List<dynamic> time;

    TimeCycle(this.names, this.time);
    
    factory TimeCycle.fromJson(Map<String, dynamic> json) {
      List<String> stopNames = new List<String>();
      List<String> stopTimes = new List<String>();
        try{
      for (var key in json.keys){
          //String lengthTest = '45faa741-a162-4adb-ae59-164a0316ec8a';
          var mykey = key.substring(36);
          stopNames.add(mykey);
      }
      for (var val in json.values){
          stopTimes.add(val);
      }
        }catch (e){
            
        }
      return new TimeCycle(
          stopNames, 
          stopTimes
          );
      
    }
}