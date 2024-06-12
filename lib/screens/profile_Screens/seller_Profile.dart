import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../products/product_Details.dart';


class SellerProfile extends StatefulWidget {
  String? email;

  SellerProfile({
    this.email,
  });

  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
          "Seller Profile",
          style: TextStyle(
            fontSize: 16,
            color: KSecondaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            height: 170,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: FutureBuilder(
                      future: _firebaseFirestore
                          .collection("User")
                          .doc(widget.email)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.network(
                            '${snapshot.data!["Profile Image"]}',
                            fit: BoxFit.cover,
                            height: Get.height,
                            width: Get.width,
                          );
                        } else {
                          return Container(
                            width: 124,
                            height: 124,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: _firebaseFirestore
                          .collection("User")
                          .doc(widget.email)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data!["First Name"]} ${snapshot.data!["Last Name"]}",
                            style: TextStyle(
                              color: KPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: _firebaseFirestore
                          .collection("User")
                          .doc(widget.email)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data!["Shop Name"]}",
                            style: TextStyle(
                              color: KBlackColor.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Published Products",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: KBlackColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: _firebaseFirestore
                .collection("Products")
                .where("Email Address", isEqualTo: widget.email)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return productTile(index, doc);
                    },
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

  Widget productTile(int index, DocumentSnapshot doc) {
    return Card(
      elevation: 3,
      color: KWhiteColor,
      margin: EdgeInsets.only(bottom: 15,left: 15,right: 15),
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
