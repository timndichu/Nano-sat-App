class SensorReading {
  final num val;
  final String date;
  final String time;
  final num x;
  final num y;
  final num z;
  
 
  SensorReading({
    this.val,
    this.time,
    this.date,
    this.x,
    this.y,
    this.z
 
  });

  Map toJson() => {
        'val': val,
        'time': time,
        'date': date,
        'x': x,
        'y': y,
        'z': z
      };
  factory SensorReading.fromJson(Map<String, dynamic> json) => SensorReading(
        val: json['val'],
        time: json['time'],
        date: json['date'],
        x: json['x'],
        y: json['y'],
        z: json['z']
      );
}
