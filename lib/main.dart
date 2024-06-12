import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vendors_app/screens/admin_Panel/admin_Panel.dart';
import 'package:vendors_app/screens/launch/launch.dart';
import 'package:vendors_app/screens/splash_Screen/splash_Screen.dart';
import 'package:vendors_app/screens/user/sign_In.dart';
import 'package:vendors_app/screens/user/sign_Up.dart';

import 'firebase_options.dart';
import 'helper/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(StockRoom());
}

class StockRoom extends StatefulWidget {
  @override
  _StockRoomState createState() => _StockRoomState();
}

class _StockRoomState extends State<StockRoom> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        scaffoldBackgroundColor: KSecondaryColor,
        fontFamily: 'Montserrat-Regular',
        primaryColor: KPrimaryColor,
        canvasColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: KBlackColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: KPrimaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: KPrimaryColor,
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          splashColor: KPrimaryColor.withOpacity(0.5),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: KPrimaryColor.withOpacity(0.2)),
      ),
      initialRoute: '/splash_Screen',
      getPages: [
        GetPage(name: '/splash_Screen', page: () => SplashScreen()),
        GetPage(name: '/launch', page: () => Launch()),
        GetPage(name: '/sign_In', page: () => SignIn()),
        GetPage(name: '/sign_Up', page: () => SignUp()),
        //  admin
        GetPage(name: '/admin_Panel', page: () => AdminLogin()),
      ],
    ); 
  }
}
