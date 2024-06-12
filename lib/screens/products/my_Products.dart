import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendors_app/screens/products/product_Details.dart';
import 'package:vendors_app/screens/products/update_Product.dart';

import '../../helper/constant.dart';
import '../alert_Dialouges/delete_Product.dart';
import '../utils/singleton.dart';


class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
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
        title: Container(
          child: Image.asset(
            'assets/StockRoom.png',
            height: 15.85,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Image.asset(
                'assets/search.png',
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Text(
            "Your Products",
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
            child: StreamBuilder(
              stream: _firebaseFirestore
                  .collection("Products")
                  .where("Email Address",
                      isEqualTo: "${UserSingleton.userData.email}")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return productTile(index, doc);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
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
            Stack(
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
                  margin: EdgeInsets.only(top: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Get.dialog(
                          DeleteProduct(
                            pId: "${doc.id}",
                          ),
                          transitionDuration: Duration(
                            milliseconds: 300,
                          ),
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(
                          () => UpdateProduct(
                            uId: "${doc.id}",
                          ),
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: KBlackColor,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              color: KBlackColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: ListTile(
                title: Text(
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
