import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../chat/recent_Chats_Or_Friends.dart';
import '../home_Page/home_Page.dart';
import '../products/my_Products.dart';
import '../profile_Screens/profile_Menu.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: KPrimaryColor,
        child: ListView(
          children: [
            Container(
              height: 130,
              child: Center(
                child: ListTile(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Image.asset(
                      'assets/Group 77.1.png',
                      height: 13,
                    ),
                  ),
                  title: Image.asset(
                    'assets/StockRoom.png',
                    height: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () => Get.off(() => HomePage()),
              leading: Image.asset(
                'assets/Group 317.png',
                height: 16,
                color: KGreyColor.withOpacity(0.5),
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 16,
                  color: KSecondaryColor,
                ),
              ),
            ),
            ListTile(
              onTap: () => Get.to(() => MyProducts()),
              leading: Image.asset(
                'assets/Group 298.png',
                height: 16,
              ),
              title: Text(
                "My Products",
                style: TextStyle(
                  fontSize: 16,
                  color: KSecondaryColor,
                ),
              ),
            ),
            ListTile(
              onTap: () => Get.to(() => RecentChatsOrFriends()),
              leading: Icon(
                Icons.people,
                size: 20,
                color: KSecondaryColor.withOpacity(0.3),
              ),
              title: Text(
                "Recent Chats",
                style: TextStyle(
                  fontSize: 16,
                  color: KSecondaryColor,
                ),
              ),
            ),
            ListTile(
              onTap: () => Get.to(ProfileMenu()),
              leading: Image.asset(
                'assets/Group 313.png',
                height: 16,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 16,
                  color: KSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
