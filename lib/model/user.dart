import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  // Do not store password in Firestore unless absolutely necessary
  // final String password;

  User({
    required this.name,
    required this.email,
    // required this.password,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        // "password": password, // Avoid storing passwords here
      };

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User(
      name: data['name'],
      email: data['email'],
      // password: data['password'], // Avoid retrieving passwords from Firestore
    );
  }
}
