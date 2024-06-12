import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../user/sign_In.dart';
import '../user/sign_Up.dart';


class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: KPrimaryColor,
                child: Center(
                  child: Image.asset(
                    'assets/StockRoom.png',
                    height: 23.94,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: KPrimaryColor,
                        ),
                      ),
                      height: 56,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        shape: StadiumBorder(),
                        color: KPrimaryColor,
                        onPressed: () => Get.to(() => SignIn()),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: KSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: KPrimaryColor,
                        ),
                      ),
                      height: 56,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        shape: StadiumBorder(),
                        color: KSecondaryColor,
                        onPressed: () => Get.to(() => SignUp()),
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: KPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
