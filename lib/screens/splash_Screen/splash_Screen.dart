import 'dart:async';
import 'package:flutter/material.dart';

import '../../helper/constant.dart';
import '../utils/current_User_Data.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 3), () => currentUserData());
  }

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Rectangle 11.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: KPrimaryColor.withOpacity(0.85),
                ),
                child: Center(
                    child: Image.asset(
                  'assets/StockRoom.png',
                  height: 23.94,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
