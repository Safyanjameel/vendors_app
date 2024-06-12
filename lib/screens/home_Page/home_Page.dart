import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../helper/constant.dart';
import '../bottom_Sheets/add_Product_Bottom_Sheet.dart';
import '../my_Drawer/my_Drawer.dart';
import '../products/product_Details.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Image.asset(
            'assets/Group 77.2.png',
            height: 15,
            color: KSecondaryColor,
          ),
        ),
        title: Text(
          "Homepage",
          style: TextStyle(
            fontSize: 16,
            color: KSecondaryColor,
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: Get.width,
                      color: KSecondaryColor,
                      child: StreamBuilder(
                        stream: _firebaseFirestore
                            .collection("Products")
                            .orderBy("Added Date", descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: [
                                Text(
                                  "Popular Products",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: KBlackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot doc =
                                          snapshot.data!.docs[index];
                                      return productTile(index, doc);
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: 56,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 5,
                          color: KPrimaryColor,
                          textColor: KSecondaryColor,
                          splashColor: Color(0xfffafafa),
                          highlightColor: Colors.white,
                          onPressed: () =>
                              Get.bottomSheet(AddProductBottomSheet()),
                          child: Text(
                            "Sell your product".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productTile(int index, DocumentSnapshot doc) {
    return Card(
      elevation: 3,
      color: KWhiteColor,
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              width: Get.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Image.network(
                  "${doc.data()["Product Image"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: ListTile(
                title:  Text(
                  "${doc.data()["Company"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                subtitle: Text(
                  "${doc.data()["Product Name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: "Montserrat-Regular",
                            color: KBlackColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Rs/-',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: ' ${doc.data()["Price"]}',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat-Regular",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      height: 20,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        onPressed: () => Get.to(
                              () => ProductDetails(
                            productId: "${doc.id}",
                          ),
                        ),
                        elevation: 0,
                        color: Color(0xffBAC8F4),
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 8,
                            color: KPrimaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
