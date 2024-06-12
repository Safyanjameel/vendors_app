import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../utils/singleton.dart';


class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
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
          "Profile Details",
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: KWhiteColor,
                elevation: 5,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "First Name",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.fName}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "Last Name",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.lName}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "Email Address",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.email}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "Shop Name",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.shopName}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "Shop Address",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.shopAddress}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "About",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.about}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          "Joining Date",
                          style: TextStyle(
                            fontSize: 16,
                            color: KBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${UserSingleton.userData.createdAt}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
