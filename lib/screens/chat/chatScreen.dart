import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../utils/singleton.dart';


// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String? roomID;
  String? userEmail;

  ChatScreen({this.roomID, this.userEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? selectedRoomId;
  var listMessage;
  ScrollController _scrollController = ScrollController();

  bool isSendIcon = false;
  TextEditingController? textcontroller;
  String textsaver = "";

  @override
  void initState() {
    print("in room id  ${widget.roomID}");
    print("in room id  ${widget.userEmail}");
    super.initState();
    textcontroller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textcontroller!.dispose();
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          backgroundColor: Colors.white,
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
              "Chat Screen",
              style: TextStyle(
                fontSize: 16,
                color: KSecondaryColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * .02),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * .01,
                  ),
                  Expanded(child: conversation()),
                  Expanded( child: bottomtextnavigation()),
                ],
              ),
            ),
          )),
    );
  }

  Widget bottomtextnavigation() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 5,
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          title: TextField(
            textAlign: TextAlign.start,
            controller: textcontroller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) {
              setState(() {
                if (textcontroller!.text.isNotEmpty) {
                  isSendIcon = true;
                } else {
                  isSendIcon = false;
                }
              });
              textsaver = value;
              print("text saver   " + textsaver);
            },
            style: TextStyle(fontSize: 13, color: KBlackColor),
            cursorColor: KBlackColor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Color(0xffD5DDE0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: Color(0xffD5DDE0),
                ),
              ),
              hintText: "Write Something",
              suffixIcon: Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // textcontroller.clear();
                        // if (isSendIcon && textsaver.isNotEmpty) {
                        //   chatList.add(sendchat(5, textsaver));
                        //   textsaver = "";
                        // } else {
                        //   Fluttertoast.showToast(msg: "Please type something");
                        // }
                        onSendMessage(textcontroller!.text);
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      color: KBlackColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSendMessage(
    String content,
  ) {
// type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textcontroller!.clear();
      var documentReference = FirebaseFirestore.instance
          .collection('Chats')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'message': content,
            'receiverId': widget.userEmail,
            'senderId': UserSingleton.userData.email,
            'roomId': widget.roomID,
            'createdAt': Timestamp.now(),
            'seen': false,
            'type': 1,
          },
        );
      });
      _controller.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget conversation() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chats')
          .where("roomId", isEqualTo: widget.roomID)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No conversation history found"));
        } else {
          listMessage = snapshot.data!.docs;
          print(listMessage.length);
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) =>
                buildItem(index, snapshot.data!.docs[index]),
            itemCount: snapshot.data!.docs.length,
            reverse: true,
            controller: _scrollController,
          );
        }
      },
    );
  }

  Widget buildItem(
    int index,
    DocumentSnapshot document,
  ) {
    if (document.data()['senderId'] == UserSingleton.userData.email) {
// Right (my message)
      return Column(children: [
        sendChat(
          index,
          document.data()['message'],
          document.data()['type'],
        ),
      ]);
    } else {
// Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            receivedChat(
              document.data()['message'],
              index,
              document.data()["senderId"],
              document.data()['type'],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  Widget sendChat(int index, String text, int type) {
    return Container(
      margin: EdgeInsets.only(
        right: 5,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Card(
                elevation: 3,
                margin: EdgeInsets.only(left: 10, bottom: 16),
                color: KPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(0),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .7,
                    minWidth: 1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "${UserSingleton.userData.profileImage}",
                  fit: BoxFit.cover,
                  width: Get.width,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedChat(
    String text,
    int index,
    String sender,
    int type,
  ) {
    return Container(
      margin: EdgeInsets.only(
        right: 5,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("User")
                    .doc(sender)
                    .get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return CircleAvatar(
                      radius: 18,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "${snapshot.data!["Profile Image"]}",
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                      ),
                    );
                  }
                }),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Card(
                elevation: 3,
                margin: EdgeInsets.only(left: 5),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .7,
                      minWidth: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          text
                          ,style: TextStyle(color: KBlackColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
