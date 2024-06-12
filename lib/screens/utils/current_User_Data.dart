import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors_app/screens/user/sign_Up.dart';
import 'package:vendors_app/screens/utils/singleton.dart';

import '../home_Page/home_Page.dart';
import '../user/sign_In.dart';


void currentUserData() {
  User user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _fs = FirebaseFirestore.instance;
  if (user != null) {
    print("${user.email}");
    _fs.collection("User").doc(user.email).get().then((cd) {
      if (cd.data != null) {
        print("cd has the data");
        UserSingleton.userData.profileImage = cd.data()["Profile Image"];
        UserSingleton.userData.fName = cd.data()["First Name"];
        UserSingleton.userData.lName = cd.data()["Last Name"];
        UserSingleton.userData.email = cd.data()["Email"];
        UserSingleton.userData.password = cd.data()["Password"];
        UserSingleton.userData.phone = cd.data()["Phone Number"];
        UserSingleton.userData.shopName = cd.data()["Shop Name"];
        UserSingleton.userData.shopAddress = cd.data()["Shop Address"];
        UserSingleton.userData.about = cd.data()["About"];
        UserSingleton.userData.createdAt = cd.data()["Created At"];
      } else {
        print("Account not found!");
        Get.off(() => SignUp());
      }
    }).then((value) => Get.off(() => HomePage()));
  } else {
    print("User doesn't exist");
    Get.off(() => SignIn());
  }
}
