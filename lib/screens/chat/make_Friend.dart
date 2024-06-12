import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/fb_Collections.dart';
import '../utils/singleton.dart';


Future<void> makeFriend(String friendTo) async {
  try {
    var id = Timestamp.now().millisecondsSinceEpoch.toString();
    FbCollections.friends.doc(id).set({
      "Created At": Timestamp.now(),
      "Friend By": UserSingleton.userData.email,
      "Friend To": friendTo,
      "Is Friend": true,
    });
  } catch (e) {
    print("$e");
  }
}
