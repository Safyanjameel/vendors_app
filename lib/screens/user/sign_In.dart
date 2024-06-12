import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:vendors_app/screens/user/sign_Up.dart';

import '../../controller/sign_In_Controller.dart';
import '../../helper/constant.dart';
import '../../widget/headings.dart';
import '../../widget/myTextField.dart';
import '../admin_Panel/admin_Panel.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _controller = SignInController();

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
                  "Login to\nContinue",
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
                  validator:
                      RequiredValidator(errorText: 'Invalid Email Address'),
                  controller: _controller.emailCon,
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
                  validator: RequiredValidator(errorText: 'Invalid Password'),
                  controller: _controller.passCon,
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
                           _controller.login(
                            "${_controller.emailCon.text.trim()}",
                            "${_controller.passCon.text.trim()}",
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(AdminLogin()),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Authorized Account?",
                            style: TextStyle(
                              color: KPrimaryColor,
                              fontFamily: "Montserrat-Regular",
                            ),
                          ),
                          TextSpan(
                            text: " Login",
                            style: TextStyle(
                              color: KPrimaryColor,
                              fontFamily: "Montserrat-Regular",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: KSecondaryColor,
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.to(SignUp()),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat-Regular",
                      ),
                    ),
                    TextSpan(
                      text: " Sign up",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat-Regular",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
