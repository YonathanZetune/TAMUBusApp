class Bus {
    String group;
    String color;
    String name;
    String lineNum;

    // rename this method. not sure what it does exactly, but "getColor" is not descriptive
    static String getColor(String col){
        if (col.toLowerCase().contains('ff') == false)
          return "ff5c0000";
        else return col;
    }

    Bus(this.group, this.color, this.name, this.lineNum);
    
    factory Bus.fromJson(Map<String, dynamic> json) {
      return new Bus(
        json["Group"]['Name'],
        getColor(json["Pattern"]["LineInfo"]["Color"]),
        json["Name"],
        json["ShortName"]
      );
    }
}