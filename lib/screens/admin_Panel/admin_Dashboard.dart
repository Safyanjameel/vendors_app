import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors_app/helper/constant.dart';
import 'package:vendors_app/screens/admin_Panel/all_Users.dart';
import 'package:vendors_app/screens/admin_Panel/shortcut_Cards.dart';
import 'package:vendors_app/screens/user/sign_In.dart';


class AdminDashBoard extends StatefulWidget {
  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  List titles = [
    'Users',
    'Profile',
  ];
  List onTaps = [
    AllUsers(),
    () {},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              'assets/Union.png',
              height: 15,
            ),
          ),
        ),
        title: Text(
          "Dashboard",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: KWhiteColor),
        ),
        actions: [
          GestureDetector(
            onTap: () => _auth.signOut().then(
                  (value) => Get.offAll(() => SignIn()),
                ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(
                  "Sign out",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KWhiteColor,
                  ),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              shrinkWrap: true,
              itemCount: titles.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) => ShortcutCards(
                title: '${titles[index]}',
                onTap: onTaps[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
