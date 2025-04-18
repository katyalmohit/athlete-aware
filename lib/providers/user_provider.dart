import 'package:athlete_aware/model/user.dart';
import 'package:athlete_aware/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  User? _user;
  final AuthMethods _authMethods = AuthMethods();  

  User get getUser => _user!;

  Future<void> refreshUser() async{
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
  
}