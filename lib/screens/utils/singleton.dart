import 'package:flutter/material.dart';

class UserSingleton {
  static final UserSingleton _userSingleton = UserSingleton._internal();

  factory UserSingleton() => _userSingleton;

  UserSingleton._internal();

  static UserSingleton get userData => _userSingleton;

  UserSingleton? user;
  String profileImage = '';
  String email = '';
  String fName = '';
  String lName = '';
  String password = '';
  String phone = '';
  String shopName = '';
  String shopAddress = '';
  String about = '';
  String createdAt = '';
  String updatedAt = '';
}
