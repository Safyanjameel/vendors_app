import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors_app/screens/profile_Screens/faq.dart';
import 'package:vendors_app/screens/profile_Screens/profile_Details.dart';
import 'package:vendors_app/screens/profile_Screens/term_And_Conditions.dart';

import '../../helper/constant.dart';
import '../user/sign_In.dart';
import '../utils/singleton.dart';
import 'change_Password.dart';
import 'edit_Profile.dart';


class ProfileMenu extends StatefulWidget {
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: Image.asset(
              'assets/Union.png',
              height: 15,
            ),
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 16,
            color: KWhiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(0, 200),
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      '${UserSingleton.userData.profileImage}',
                      fit: BoxFit.cover,
                      height: Get.height,
                      width: Get.width,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${UserSingleton.userData.fName} ${UserSingleton.userData.lName}",
                  style: TextStyle(
                    fontSize: 16,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${UserSingleton.userData.email}",
                  style: TextStyle(
                    fontSize: 14,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: KWhiteColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () => Get.to(()=> ProfileDetails()),
                        title: Text(
                          "Profile Details",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () => Get.to(EditProfile()),
                        title: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () => Get.to(ChangePassword()),
                        title: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () => Get.to(TermsAndConditions()),
                        title: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: ()=> Get.to(()=> FAQ()),
                        title: Text(
                          "FAQ",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        title: Text(
                          "About App",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Get.offAll(() => SignIn()),
                      );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 30),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
