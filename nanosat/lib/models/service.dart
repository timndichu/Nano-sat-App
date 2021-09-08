class Service {
  final num id;
  final String title;
  final String imageUrl;
 

  Service({
    this.title,
    this.id,
    this.imageUrl,
  
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        
      };
  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        title: json['title'],
        imageUrl: json['imageUrl'],
       
      );
}
