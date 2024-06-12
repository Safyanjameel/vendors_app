import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../products/add_Products.dart';


class AddProductBottomSheet extends StatefulWidget {
  static String id = "ScanImageSearchImage";

  @override
  _AddProductBottomSheetState createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                width: 30,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                  color: Color(0xffD5DDE0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Upload your product and make it available for sales.",
                style: TextStyle(
                  fontSize: 16,
                  color: KBlackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width * 0.75,
            child: MaterialButton(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: KPrimaryColor,
              textColor: Color(0xfffafafa),
              onPressed: () => Get.off(AddProduct()),
              child: Text(
                "Add Product".toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
