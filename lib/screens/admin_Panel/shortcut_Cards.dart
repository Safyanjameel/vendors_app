import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';


class ShortcutCards extends StatelessWidget {
  var title, onTap;

  ShortcutCards({
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => onTap),
      child: Card(
        elevation: 5,
        child: Container(
          child: Center(
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: 16,
                color: KBlackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
