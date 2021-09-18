import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  String _email = '';

  String _phone = '';

  String get email {
    return _email;
  }

  String get phone {
    return _phone;
  }

  Map<String, dynamic> _user = {};

  Map<String, dynamic> get user {
    return Map.from(_user);
  }

  User _loggedUser;

  User get loggedUser {
    return _loggedUser;
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  String _firstName = '';

  String get firstName {
    return _firstName;
  }

  bool _hasError = false;

  bool get hasError {
    return _hasError;
  }

 


  String baseurl = "https://victorycakes.co.ke";

  String formatter(String url) {
    return baseurl + url;
  }



  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<dynamic> postSignUp(String url, Map<String, String> body) async {
    url = formatter(url);
  
      bool hasError = true;
    String message = 'Something went wrong';
    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json"}, body: json.encode(body))  .catchError((error) {
        return {
          'message': message + 'Check your Internet connection',
          'success': hasError
        };
      });

    final Map<String, dynamic> responseData = json.decode(response.body);

    String token = '';

    Map<String, dynamic> userData = {};
    Map<String, dynamic> fetchedUser = {};

    if (response.statusCode == 403) {
      hasError = true;
      message = responseData['msg'];
    } else if (response.statusCode == 401 ||
        response.statusCode == 500) {
      hasError = true;
      message = responseData['msg'];
    } else if (response.statusCode == 200) {
      hasError = false;
      message = responseData['msg'];

      userData = responseData['user'];

      print(
          '===========////////////////////////////LOGGED USER///////////////////////////==============');

      final User theUser = User(
          firstName: userData['firstName'],
          lastName: userData['lastName'],
          email: userData['email'],
          phone: userData['phone'],
          residence: userData['residence']);
      fetchedUser['user'] = theUser;
      _user = fetchedUser;

      _loggedUser = theUser;

      _isLoading = false;
      notifyListeners();
    } else {
      message = 'Something went wrong, Check your network';
      _isLoading = false;
      notifyListeners();
    }

    return {'success': !hasError, 'message': message};
  }

  Future<dynamic> postLogin(String url, Map<String, String> body) async {
    url = formatter(url);

    bool hasError = true;
    String message = 'Something went wrong';
    String token = '';
  
  try{
      var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json"}, body: json.encode(body));
      print(response.body);
      final Map<String, dynamic> responseData = new Map<String, dynamic>.from(json.decode(response.body));
      Map<String, dynamic> userData = {};
      Map<String, dynamic> fetchedUser = {};

      if (response.statusCode == 403) {
        hasError = true;
        message = responseData['msg'];
      } else if (response.statusCode == 401 ||
          response.statusCode == 500) {
        hasError = true;
        message = responseData['msg'];
      } else if (response.statusCode == 200) {
        hasError = false;
        message = responseData['msg'];
     
      

        print(
            '===========////////////////////////////LOGGED USER///////////////////////////==============');

      
        _isLoading = false;
        notifyListeners();
      } else {
        message = 'Something went wrong, Check your network';
        _isLoading = false;
        notifyListeners();
      }

      return {'success': !hasError, 'message': message};
    } catch (err) {
      print(err);
    }
  }




 Future fetchTheUser() async {
    Map<String, dynamic> fetchedUser = {};
   
    Map<String, dynamic> userData = {};
    _isLoading = true;
    notifyListeners();
    try {
      //Get user from Profile
    String url = formatter('/laundry/fetchUser/$_email');
        var response = await http.get(Uri.parse(url)).catchError((error) {
          _hasError = true;
          notifyListeners();
          return {
            'message': 'Check your Internet connection',
            'error': _hasError
          };
        });

     
    if (response.statusCode == 200 || response.statusCode == 201) {
      userData = json.decode(response.body);
      print(userData);
          final User theUser = User(
            firstName: userData['user']['firstName'],
            lastName: userData['user']['lastName'],
            email: userData['user']['email'],
         
            phone: userData['user']['phone'],
          
            residence: userData['user']['residence']);
       
 fetchedUser['user'] = theUser;
      _user = fetchedUser;

      _loggedUser = theUser;

   

        _isLoading = false;
        notifyListeners();
        
      
    
    } else {
      userData = json.decode(response.body);

      _isLoading = false;
      notifyListeners();
    }

    
    } catch (err) {
      print(err);
    }
  }






/*
  Future<dynamic> changePassword(String url, Map<String, String> body) async {
    url = formatter(url);

    bool hasError = true;
    String message = 'Something went wrong';

    try {
      var response = await http
          .post(url,
              headers: {"Content-type": "application/json"},
              body: json.encode(body))
          .catchError((error) {
        return {
          'message': message + 'Check your Internet connection',
          'success': hasError
        };
      });

      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);
      log.d(responseData);

      //log.i(responseData);

      if (response.statusCode == 200) {
        hasError = false;
        message = 'Success';
      } else {
        hasError = true;
        message = responseData['msg'];
      }

      return {'success': !hasError, 'message': message};
    } catch (err) {
      print(err);
    }

    // log.d(response.statusCode);
    // log.d(response.body);
    //   log.i(response.body);
    //   return [json.decode(response.body), response.statusCode ];
  }

 

 
*/

}
