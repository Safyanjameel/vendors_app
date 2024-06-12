import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore fs = FirebaseFirestore.instance;

class FbCollections {
  static CollectionReference user = fs.collection("User");
  static CollectionReference products = fs.collection("Products");
  static CollectionReference friends = fs.collection("Friends");
}
