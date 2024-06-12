import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors_app/screens/user/sign_In.dart';

import '../../controller/sign_Up_Controller.dart';
import '../../controller/validators.dart';
import '../../helper/constant.dart';
import '../../widget/headings.dart';
import '../../widget/myTextField.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;

  final _controller = SignUpController();

  GlobalKey<FormState> _suKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Image.asset(
              'assets/Union.png',
              height: 15,
            ),
          ),
        ),
        title: Container(
          child: Image.asset(
            'assets/StockRoom.png',
            height: 15.85,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _suKey,
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
                  "Sign up\nto Continue",
                  style: TextStyle(
                    color: KPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("First Name"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _controller.fNameCon,
                  hintText: "Alex",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Last Name"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _controller.lNameCon,
                  hintText: "Wright",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Email"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
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
                  validator: passwordValidator,
                  controller: _controller.passwordCon,
                  hintText: "*******",
                  obSecure: true,
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Shop Name"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _controller.shopNameCon,
                  hintText: "Johny Hardware Store",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Shop Address"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _controller.shopAddressCon,
                  hintText: "123 Main Street, New York, NY 10030",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("About"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _controller.aboutCon,
                  hintText: "I'm known for well-organized team player.",
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    decoration: BoxDecoration(
                      border: Border.all(color: buttonBorderColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 46,
                    child: MaterialButton(
                      elevation: 0,
                      highlightElevation: 0,
                      color: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        if (_suKey.currentState!.validate()) {
                          _controller.signIn(
                            "${_controller.emailCon.text}",
                            "${_controller.passwordCon.text}",
                          );
                        } else {
                          print("Something is wrong");
                        }
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: buttonTextColor,
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
      bottomNavigationBar: BottomAppBar(
        color: KSecondaryColor,
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Have an account?",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat-Regular",
                      ),
                    ),
                    TextSpan(
                      text: " Log In",
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
