import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../../widget/headings.dart';
import '../../widget/myTextField.dart';
import 'admin_Dashboard.dart';


class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> adminLogin(String email, String pass) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
            emailCon.clear();
            passCon.clear();
          }).then((value) => Get.off(() => AdminDashBoard()));
    } catch (e) {
      print("This is exception $e");
    }
  }

  GlobalKey<FormState> _lKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Container(
          child: Image.asset(
            'assets/StockRoom.png',
            height: 15.85,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _lKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Admin Login",
                  style: TextStyle(
                    color: KPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("Email"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: emailCon,
                  validator:
                      RequiredValidator(errorText: 'Invalid Email Address'),
                  // controller: _controller.emailCon,
                  hintText: "example123@gmail.com",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Password"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller:passCon,
                  validator: RequiredValidator(errorText: 'Invalid Password'),
                  // controller: _controller.passCon,
                  obSecure: true,
                  hintText: "*******",
                ),
                SizedBox(
                  height: 18,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: 48,
                    child: MaterialButton(
                      elevation: 0,
                      highlightElevation: 0,
                      color: KPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        if (_lKey.currentState!.validate()) {
                         adminLogin(
                            "${emailCon.text}",
                            "${passCon.text}",
                          );
                        } else {
                          print("Email password incorrect");
                        }
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: KSecondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
