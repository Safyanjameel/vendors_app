import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';



class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: KSecondaryColor,
            size: 22,
          ),
        ),
        title: Text(
          "All Users",
          style: TextStyle(
            fontSize: 16,
            color: KSecondaryColor,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
