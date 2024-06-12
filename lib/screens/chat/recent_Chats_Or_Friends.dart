import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constant.dart';
import '../utils/fb_Collections.dart';
import '../utils/singleton.dart';
import 'chatScreen.dart';
import 'initiatChat.dart';


class RecentChatsOrFriends extends StatefulWidget {
  @override
  _RecentChatsOrFriendsState createState() => _RecentChatsOrFriendsState();
}

class _RecentChatsOrFriendsState extends State<RecentChatsOrFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              'assets/Union.png',
              height: 15,
            ),
          ),
        ),
        title: Text(
          "Recent Chats",
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Text(
            "Your Friends",
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
              stream: FbCollections.friends
                  .where(
                    "Friend By",
                    isEqualTo: "${UserSingleton.userData.email}",
                  )
                  .where("Is Friend", isEqualTo: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return recentChats(index, doc);
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

  Widget recentChats(int index, DocumentSnapshot doc) {
    return GestureDetector(
      onTap: () {
        InitiateChat(
          to: "${doc.data()["Friend To"]}",
          by: "${UserSingleton.userData.email}",
          name: "User",
          peerId: "${doc.data()["Friend To"]}",
        ).now().then((val) {
          Get.to(
            () => ChatScreen(
              roomID: val.roomId,
              userEmail: "${doc.data()["Friend To"]}",
            ),
          );
        });
      },
      child: Card(
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
                child: ListTile(
                  title: Text(
                    "${doc.data()["Friend To"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: Text(
                    "yes",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
    );
  }
}
