class ImagingModel {
  
  final String imageUrl;
  final String date;
  final String category;
  final String subcategory;
  
 
  ImagingModel({
   
    this.imageUrl,
    this.date,
    this.category,
    this.subcategory,
 
  });

  Map toJson() => {
       
        'imageUrl': imageUrl,
        'date': date,
        'category': category,
        'subcategory': subcategory,
      };
  factory ImagingModel.fromJson(Map<String, dynamic> json) => ImagingModel(
       
        imageUrl: json['imageUrl'],
          date: json['date'],
            category: json['category'],
              subcategory: json['subcategory'],
      );
}
