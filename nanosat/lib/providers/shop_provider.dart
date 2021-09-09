// import 'dart:convert';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;



// class ShopProvider extends ChangeNotifier {
//   String baseurl = "https://victorycakes.co.ke";
//   // String baseurl = "http://localhost:3000";

//   String formatter(String url) {
//     return baseurl + url;
//   }

//   bool _isLoading = false;

//   bool get isLoading {
//     return _isLoading;
//   }

//     bool _isServicesLoading = false;

//   bool get isServicesLoading {
//     return _isServicesLoading;
//   }

//   List<Product> _products = [];

//   List<Product> get products {
//     return List.from(_products);
//   }

//   List<Service> _services = [];

//   List<Service> get services {
//     return List.from(_services);
//   }

//   List<String> _dropDownServices = [];

//     List<String> get dropDownServices {
//     return List.from(_dropDownServices);
//   }


//   Future getServices() async {
//     _services.clear();
//     Map<String, dynamic> responseData = {};
//     List<Service> fetchedServices = [];
//       List<String> allDropDownServices = [];
//      _isLoading = true;
//       notifyListeners();
//     String url = formatter('/laundry/getServices');

//     var response = await http.get(url);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       responseData = json.decode(response.body);
//       responseData['services'].forEach((dynamic item) {
//         final Service service = Service(
//           id: item['id'],
//           title: item['title'],
//           imageUrl: item['image'],
//         );
//         fetchedServices.add(service);
        
//       });
//       _services = fetchedServices;
//          notifyListeners();
//       _isLoading = false;
//       notifyListeners();
//     } else {
//       responseData = json.decode(response.body);

//       _isLoading = false;
//       notifyListeners();
//     }
//   }


//   Future get5Services() async {
//     _services.clear();
//     Map<String, dynamic> responseData = {};
//     List<Service> fetchedServices = [];
//       List<String> allDropDownServices = [];
//      _isServicesLoading = true;
//       notifyListeners();
//     String url = formatter('/laundry/get5Services');

//     var response = await http.get(url);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       responseData = json.decode(response.body);
//       responseData['services'].forEach((dynamic item) {
//         final Service service = Service(
//           id: item['id'],
//           title: item['title'],
//           imageUrl: item['image'],
//         );
//         fetchedServices.add(service);
        
//       });
//       _services = fetchedServices;
//          notifyListeners();
//       _isServicesLoading = false;
//       notifyListeners();
//     } else {
//       responseData = json.decode(response.body);

//       _isServicesLoading = false;
//       notifyListeners();
//     }
//   }

//     Future getProducts(int serviceId) async {
//       _products.clear();
//     Map<String, dynamic> responseData = {};
//     List<Product> fetchedProducts = [];
//      _isLoading = true;
//       notifyListeners();
//     String url = formatter('/laundry/getProducts/$serviceId');

//     var response = await http.get(url);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       responseData = json.decode(response.body);
//       responseData['products'].forEach((dynamic item) {
//         final Product product = Product(
//           id: item['id'],
//           title: item['title'],
//           image: item['image'],
//           price: item['price'],
//           serviceId: item['serviceId']
//         );
//         fetchedProducts.add(product);
//       });
//       _products = fetchedProducts;
//         notifyListeners();
//       _isLoading = false;
//       notifyListeners();
//     } else {
//       responseData = json.decode(response.body);

//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<dynamic> postProduct(String productName, String price,
//       int serviceId, PlatformFile image) async {
//     var url = formatter('/laundry/postProduct');
//     var uri = Uri.parse(url);
//     bool hasError = true;
//     String message = 'Something went wrong';

//     if (image != null) {
//       var request = new http.MultipartRequest('POST', uri);
//       request.headers.addAll({
//         "Content-type": "multipart/form-data",
//       });

//       request.fields['productName'] = productName;
//       request.fields['price'] = price;
//       request.fields['serviceId'] = serviceId.toString();

//       print('IMAGE IS HERE');

//       var multipartFile = new http.MultipartFile(
//           "image", image.readStream, image.size,
//           filename: image.name);

//       request.files.add(multipartFile);
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         print("Image Uploaded");
//         hasError = false;
//       } else {
//         print("Upload Failed");
//         hasError = true;
//         message = "Upload failed";
//       }
//       response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//       });
//     } else {
//       hasError = true;
//       message = "No image Selected";
//     }

//     return {'success': !hasError, 'message': message};
//   }

//   Future<dynamic> postService(String serviceName, PlatformFile image) async {
//     var url = formatter('/laundry/postService');
//     var uri = Uri.parse(url);
//     bool hasError = true;
//     String message = 'Something went wrong';

//     if (image != null) {
//       var request = new http.MultipartRequest('POST', uri);
//       request.headers.addAll({
//         "Content-type": "multipart/form-data",
//       });

//       request.fields['serviceName'] = serviceName;

//       print('IMAGE IS HERE');

//       var multipartFile = new http.MultipartFile(
//           "image", image.readStream, image.size,
//           filename: image.name);

//       request.files.add(multipartFile);
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         print("Image Uploaded");
//         hasError = false;
//       } else {
//         print("Upload Failed");
//         hasError = true;
//         message = "Upload failed";
//       }
//       response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//       });
//     } else {
//       hasError = true;
//       message = "No image Selected";
//     }

//     return {'success': !hasError, 'message': message};

//   }



//    Future<dynamic> updateServiceWithImage(String serviceName, PlatformFile image, int id) async {
//     var url = formatter('/laundry/updateServiceWithImage');
//     var uri = Uri.parse(url);
//     bool hasError = true;
//     String message = 'Something went wrong';

//     if (image != null) {
//       var request = new http.MultipartRequest('POST', uri);
//       request.headers.addAll({
//         "Content-type": "multipart/form-data",
//       });

//       request.fields['serviceName'] = serviceName;
//       request.fields['id'] = id.toString();
//       print('IMAGE IS HERE');

//       var multipartFile = new http.MultipartFile(
//           "image", image.readStream, image.size,
//           filename: image.name);

//       request.files.add(multipartFile);
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         print("Image Uploaded");
//         hasError = false;
//       } else {
//         print("Upload Failed");
//         hasError = true;
//         message = "Upload failed";
//       }
//       response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//       });
//     } else {
//       hasError = true;
//       message = "No image Selected";
//     }

//     return {'success': !hasError, 'message': message};

//   }


//    Future<dynamic> updateServiceNoImage(String serviceName, int id) async {
//     String url = formatter('/laundry/updateServiceNoImage');
    
//     bool hasError = true;
//     String message = 'Something went wrong';


//    Map<String,String> body = {
//      "serviceName": serviceName,
//      "id": id.toString()
//    };

//     try {
//       var response = await http
//           .post(url,
//               headers: {"Content-type": "application/json"},
//               body: json.encode(body));
          

//       final Map<String, dynamic> responseData = json.decode(response.body);
    
//       if (response.statusCode == 403) {
//         hasError = true;
//         message = responseData['msg'];
//       } else if (response.statusCode == 401 ||
//           response.statusCode == 500) {
//         hasError = true;
//         message = responseData['msg'];
//       } else if (response.statusCode == 200) {
//         hasError = false;
//         message = responseData['msg'];
       

//        } else {
//         message = 'Something went wrong, Check your network';
//          hasError = true;
//         _isLoading = false;
//         notifyListeners();
//       }

//       return {'success': !hasError, 'message': message, };
//     } catch (err) {
//       print(err);
//     }
   
//   }



//  Future<dynamic> updateProductWithImage(String productName, PlatformFile image, int id, int serviceId, String price, ) async {
//     var url = formatter('/laundry/updateProductWithImage');
//     var uri = Uri.parse(url);
//     bool hasError = true;
//     String message = 'Something went wrong';

//     if (image != null) {
//       var request = new http.MultipartRequest('POST', uri);
//       request.headers.addAll({
//         "Content-type": "multipart/form-data",
//       });

//       request.fields['productName'] = productName;
//         request.fields['price'] = price;
//       request.fields['id'] = id.toString();
//       request.fields['serviceId'] = serviceId.toString();
//       print('IMAGE IS HERE');

//       var multipartFile = new http.MultipartFile(
//           "image", image.readStream, image.size,
//           filename: image.name);

//       request.files.add(multipartFile);
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         print("Image Uploaded");
//         hasError = false;
//       } else {
//         print("Upload Failed");
//         hasError = true;
//         message = "Upload failed";
//       }
//       response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//       });
//     } else {
//       hasError = true;
//       message = "No image Selected";
//     }

//     return {'success': !hasError, 'message': message};

//   }


//    Future<dynamic> updateProductNoImage(String productName, int id, int serviceId, String price) async {
//     String url = formatter('/laundry/updateProductNoImage');
    
//     bool hasError = true;
//     String message = 'Something went wrong';


//    Map<String,String> body = {
//      "productName": productName,
//      "id": id.toString(),
//      "price": price,
//        "serviceId": serviceId.toString()
//    };

//     try {
//       var response = await http
//           .post(url,
//               headers: {"Content-type": "application/json"},
//               body: json.encode(body));
          

//       final Map<String, dynamic> responseData = json.decode(response.body);
    
//       if (response.statusCode == 403) {
//         hasError = true;
//         message = responseData['msg'];
//       } else if (response.statusCode == 401 ||
//           response.statusCode == 500) {
//         hasError = true;
//         message = responseData['msg'];
//       } else if (response.statusCode == 200) {
//         hasError = false;
//         message = responseData['msg'];
       

//        } else {
//         message = 'Something went wrong, Check your network';
//          hasError = true;
//         _isLoading = false;
//         notifyListeners();
//       }

//       return {'success': !hasError, 'message': message };
//     } catch (err) {
//       print(err);
//     }
   
//   }








//  Future deleteService(int id) async {
//      bool hasError = true;
//     String message = 'Something went wrong';

//     Map<String, dynamic> responseData = {};
//     List<Service> fetchedServices = [];
//      _isLoading = true;
//       notifyListeners();
//     String url = formatter('/laundry/deleteService/$id');

//     var response = await http.get(url);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       responseData = json.decode(response.body);
//         hasError = false;
//        responseData['services'].forEach((dynamic item) {
//         final Service service = Service(
//           id: item['id'],
//           title: item['title'],
//           imageUrl: item['image'],
//         );
//         fetchedServices.add(service);
        
//       });
//       _services = fetchedServices;
//          notifyListeners();
//       _isLoading = false;
//       notifyListeners();
    
//     } else {
//       responseData = json.decode(response.body);
//        message = "An error occurred";
//       _isLoading = false;
//       notifyListeners();
//     }
//      return {'success': !hasError, 'message': message};

//   }


// Future deleteProduct(int productId, int serviceId) async {
//      bool hasError = true;
//     String message = 'Something went wrong';

//     Map<String, dynamic> responseData = {};
//     List<Product> fetchedProducts = [];
//      _isLoading = true;
//       notifyListeners();
//     String url = formatter('/laundry/deleteProduct/$productId/$serviceId');

//     var response = await http.get(url);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       responseData = json.decode(response.body);
//         hasError = false;
//        responseData['products'].forEach((dynamic item) {
//         final Product product = Product(
//           id: item['id'],
//           title: item['title'],
//           image: item['image'],
//           price: item['price'],
//           serviceId: item['serviceId']
//         );
//         fetchedProducts.add(product);
//       });
//       _products = fetchedProducts;
//         notifyListeners();
//       _isLoading = false;
     
//     } else {
//       responseData = json.decode(response.body);
//        message = "An error occurred";
//       _isLoading = false;
//       notifyListeners();
//     }
//      return {'success': !hasError, 'message': message};

//   }













// }
