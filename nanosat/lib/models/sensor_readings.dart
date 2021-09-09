class SensorReading {
  final num val;
  final String date;
  final String time;
  
 
  SensorReading({
    this.val,
    this.time,
    this.date,
 
  });

  Map toJson() => {
        'val': val,
        'time': time,
        'date': date,
     
      };
  factory SensorReading.fromJson(Map<String, dynamic> json) => SensorReading(
        val: json['val'],
        time: json['time'],
        date: json['date'],
    
      );
}
