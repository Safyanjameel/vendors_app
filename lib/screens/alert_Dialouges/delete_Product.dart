import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';


class DeleteProduct extends StatefulWidget {
  String? pId;

  DeleteProduct({
    this.pId,
  });

  @override
  _DeleteProductState createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: KLightGreyColor,
                      border: Border.all(
                        color: KPrimaryColor.withOpacity(0.1),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        size: 38,
                        color: KPrimaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "Are you sure you want to delete this product?",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: KBlackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.82,
                      height: 48,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        color: KPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Products")
                              .doc(widget.pId)
                              .delete()
                              .then(
                                (value) => Get.back(canPop: true),
                              );
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: KSecondaryColor,
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
          ),
        ],
      ),
    );
  }
}
