import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../chat/make_Friend.dart';
import '../profile_Screens/seller_Profile.dart';
import '../utils/singleton.dart';


class ProductDetails extends StatefulWidget {
  String? productId;

  ProductDetails({
    this.productId,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: KSecondaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: KPrimaryColor,
            size: 22,
          ),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: 16,
            color: KPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          FutureBuilder(
            future: _firebaseFirestore
                .collection("Products")
                .doc(widget.productId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        child: Center(
                          child: Image.network(
                            '${snapshot.data!["Product Image"]}',
                            width: Get.width,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Rs/- ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: KBlackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!["Price"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: KBlackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${snapshot.data!["Product Name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: KBlackColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/placeholder.png',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${snapshot.data!["City"]},${snapshot.data!["District"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: KBlackColor.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Details",
                              style: TextStyle(
                                fontSize: 16,
                                color: KBlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                "${snapshot.data!["Price"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KBlackColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Text(
                                "Type",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                "${snapshot.data!["Product Type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KBlackColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Text(
                                "Company",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                "${snapshot.data!["Company"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KBlackColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 14,
                                color: KBlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${snapshot.data!["Product Description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: KBlackColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  border: Border.all(color: buttonBorderColor),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 46,
                                child: MaterialButton(
                                  elevation: 0,
                                  splashColor: KPrimaryColor.withOpacity(0.1),
                                  highlightColor: Colors.transparent,
                                  highlightElevation: 0,
                                  color: KSecondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  onPressed: () => Get.to(
                                    () => SellerProfile(
                                      email:
                                          "${snapshot.data!["Email Address"]}",
                                    ),
                                  ),
                                  child: Text(
                                    "View Seller Profile",
                                    style: TextStyle(
                                      color: KPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: snapshot.data!["Email Address"] ==
                                      UserSingleton.userData.email
                                  ? Container(
                                      width: Get.width,
                                      height: 47,
                                      child: MaterialButton(
                                        elevation: 0,
                                        highlightElevation: 0,
                                        color: KPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Uploaded by you",
                                          style: TextStyle(
                                            color: KSecondaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: buttonBorderColor),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height: 46,
                                      child: MaterialButton(
                                        elevation: 0,
                                        highlightElevation: 0,
                                        color: buttonColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        onPressed: () => makeFriend(
                                          "${snapshot.data!["Email Address"]}",
                                        ),
                                        child: Text(
                                          "Chat with seller",
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
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
