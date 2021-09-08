class Product {
  final num id;
  final String title;
  final String image;
  final num price;
  final num serviceId;

  Product({
    this.title,
    this.id,
    this.image,
    this.price,
    this.serviceId,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'price': price,
        'serviceId': serviceId,
      };
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        price: json['price'],
        serviceId: json['serviceId'],
      );
}
