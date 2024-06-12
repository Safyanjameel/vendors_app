import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home_Page/home_Page.dart';
import '../screens/utils/current_User_Data.dart';


class SignInController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String pass) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
            emailCon.clear();
            passCon.clear();
          })
          .then((value) => currentUserData())
          .then((value) => Get.off(() => HomePage()));
    } catch (e) {
      print("This is exception $e");
    }
  }
}
