import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../screens/user/sign_In.dart';


class SignUpController {
  TextEditingController fNameCon = TextEditingController();
  TextEditingController lNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController shopNameCon = TextEditingController();
  TextEditingController shopAddressCon = TextEditingController();
  TextEditingController aboutCon = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var createdAt = DateTime.now().toString();

  Future<void> signIn(String email, String pass) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        _firebaseFirestore.collection("User").doc(emailCon.text.trim()).set({
          "First Name": fNameCon.text.trim(),
          "Last Name": lNameCon.text.trim(),
          "Email": emailCon.text.trim(),
          "Password": passwordCon.text.trim(),
          "Shop Name": shopNameCon.text.trim(),
          "Shop Address": shopAddressCon.text.trim(),
          "About": aboutCon.text.trim(),
          "Created At": createdAt,
        }).then((value) {
          fNameCon.clear();
          lNameCon.clear();
          emailCon.clear();
          passwordCon.clear();
          shopNameCon.clear();
          shopAddressCon.clear();
          aboutCon.clear();
        }).then((value) => Get.off(() => SignIn()));
      });
    } catch (e) {
      print("This is Exception $e");
    }
  }
}
