class User {
  final String firstName;
  final String lastName;
  final String email;

  final String phone;
  final String residence;

  User({this.firstName, this.lastName, this.email, this.phone, this.residence});

  Map toJson() => {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'phone': phone,
        'residence': residence,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phone: json['phone'],
        residence: json['residence'],
      );
}
