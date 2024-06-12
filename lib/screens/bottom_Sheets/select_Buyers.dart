import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/constant.dart';


class select_Buyers extends StatefulWidget {
  @override
  _select_BuyersState createState() => _select_BuyersState();
}

class _select_BuyersState extends State<select_Buyers> {
  @override
  Widget build(BuildContext context) {
    myCustomBackButton() {
      setState(() {
        var back = Navigator.pop(context);
      });
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
          color: KWhiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
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
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "39TA-R030780105",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Belt Tightener",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: KBlackColor,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "PTAC Accessories",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: KPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: KBlackColor,
                          ),
                          children: [
                            TextSpan(
                              text: '\$ ',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: '89',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   myCustomBackButton();
                      //   showModalBottomSheet(
                      //     context: context,
                      //     // ignore: non_constant_identifier_names
                      //     builder: (Builder) => ChoosePaymentOption(),
                      //   );
                      // });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            margin: EdgeInsets.zero,
                            child: Container(
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Image.asset(
                                  'assets/dollar.png',
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              "Order Part",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   Navigator.pop(context);
                      //   Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //       builder: (context) => ChatScreen(),
                      //     ),
                      //   );
                      // });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                margin: EdgeInsets.zero,
                                child: Container(
                                  padding: EdgeInsets.only(top: 7, right: 1),
                                  width: 65,
                                  height: 65,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/ic_chat-removebg-preview.png',
                                      height: 60,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -2,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: KPrimaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: KWhiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              "Chat Seller",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      myCustomBackButton();
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          margin: EdgeInsets.zero,
                          child: Container(
                            width: 65,
                            height: 65,
                            child: Center(
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Color(0xff3E4958),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          right: 10,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/jurica-koletic-317414-unsplash.png',
                height: 60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
