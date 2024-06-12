import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/chat_Model.dart';

class InitiateChat {
  String? to;
  String? by;
  String? name;
  String? peerId;

  InitiateChat({this.peerId, this.to, this.by, this.name});

  // chat rooms from db..
  List<ChatRoomModel> chatRooms = [];

  var myChatRoom;

  var db = FirebaseFirestore.instance;

  Future<ChatRoomModel> now() async {
    QuerySnapshot querySnapshot = await db.collection("ChatRooms").get();
    querySnapshot.docs.forEach((element) {
      chatRooms.add(ChatRoomModel.fromJson(element));
    });
    if (!EmptyList.isTrue(querySnapshot.docs)) {
      List<ChatRoomModel> roomInfo = chatRooms
          .where((element) =>
              (element.createdBy == by || element.createdBy == peerId) &&
              (element.peerId == peerId || element.peerId == by))
          .toList();
      if (EmptyList.isTrue(roomInfo)) {
        myChatRoom = await getRoomDoc(to!, by!, name!);
        return ChatRoomModel.fromJson(myChatRoom.data());
      } else {
        return roomInfo[0];
      }
    } else {
      DocumentSnapshot doc = await getRoomDoc(to!, by!, name!);

      return ChatRoomModel.fromJson(doc);
    }
  }

  Future<DocumentSnapshot> getRoomDoc(String to, String by, String name) async {
    String docId = DateTime.now().millisecondsSinceEpoch.toString();
    ChatRoomModel chatRoomModel = ChatRoomModel(
      createdAt: Timestamp.now(),
      createdBy: by,
      roomId: docId,
      peerId: peerId,
      users: [by, peerId],
    );
    print(chatRoomModel.toJson());
    await db.collection("ChatRooms").doc(docId).set(chatRoomModel.toJson());
    DocumentSnapshot chatRoomDoc =
        await db.collection("ChatRooms").doc(docId).get();
    return chatRoomDoc;
  }
}

class EmptyList {
  static bool isTrue(List list) {
    if (list == null || list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
