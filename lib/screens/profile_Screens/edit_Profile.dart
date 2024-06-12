import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/validators.dart';
import '../../helper/constant.dart';
import '../../widget/headings.dart';
import '../../widget/myTextField.dart';
import '../utils/singleton.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  TextEditingController fNameCon = TextEditingController();
  TextEditingController lNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController shopNameCon = TextEditingController();
  TextEditingController shopAddressCon = TextEditingController();
  TextEditingController aboutCon = TextEditingController();

  File? _image;

  Future getImage() async {
    PickedFile img = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(img.path);
    });
  }

  Future<String> uploadImg(File needImg) async {
    String pickedImg;
    Reference ref = _firebaseStorage
        .ref()
        .child("profile Images/${DateTime.now().toString()}");
    UploadTask uploadTask = ref.putFile(needImg);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imgUrl = await taskSnapshot.ref.getDownloadURL();
    pickedImg = imgUrl.toString();
    return pickedImg;
  }

  Future<void> updatedData() async {
    String updatedAt = DateTime.now().toString();
    String finalImg = await uploadImg(_image!);
    User user = FirebaseAuth.instance.currentUser;
    _firebaseFirestore.collection("User").doc(user.email).update({
      "Profile Image": finalImg,
      "First Name": fNameCon.text.trim(),
      "Last Name": lNameCon.text.trim(),
      "Password": passwordCon.text.trim(),
      "Shop Name": shopNameCon.text.trim(),
      "Shop Address": shopAddressCon.text.trim(),
      "About": aboutCon.text.trim(),
      "Updated At": updatedAt,
    }).then((value) {
      fNameCon.clear();
      lNameCon.clear();
      passwordCon.clear();
      shopNameCon.clear();
      shopAddressCon.clear();
      aboutCon.clear();
      setState(() {
        _image = null;
      });
    }).then((value) {
      _firebaseFirestore
          .collection("User")
          .doc(user.email)
          .get()
          .then((updatedValue) {
        UserSingleton.userData.profileImage =
            updatedValue.data()["Profile Image"];
        UserSingleton.userData.fName = updatedValue.data()["First Name"];
        UserSingleton.userData.lName = updatedValue.data()["Last Name"];
        UserSingleton.userData.password = updatedValue.data()["Password"];
        UserSingleton.userData.shopName = updatedValue.data()["Shop Name"];
        UserSingleton.userData.shopAddress =
            updatedValue.data()["Shop Address"];
        UserSingleton.userData.about = updatedValue.data()["About"];
        UserSingleton.userData.updatedAt = updatedValue.data()["Updated At"];
      });
    }).then(
      (value) => Get.snackbar(
        "Successfully Updated",
        "Your profile has been updated!",
        backgroundColor: KSecondaryColor,
        snackPosition: SnackPosition.BOTTOM,
        padding: EdgeInsets.only(bottom: 30),
      ),
    );
  }

  GlobalKey<FormState> _uForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(
        elevation: 0,
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
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 16,
            color: KWhiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(0, 200),
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => getImage(),
                  child: Container(
                    width: 124,
                    height: 124,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _image == null
                              ? Image.network(
                                  '${UserSingleton.userData.profileImage}',
                                  fit: BoxFit.cover,
                                  height: Get.height,
                                  width: Get.width,
                                )
                              : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  height: Get.height,
                                  width: Get.width,
                                ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 15,
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: KWhiteColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/Group 302.png',
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${UserSingleton.userData.fName} ${UserSingleton.userData.lName}",
                  style: TextStyle(
                    fontSize: 16,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${UserSingleton.userData.email}",
                  style: TextStyle(
                    fontSize: 14,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _uForm,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                textFieldLabel("First Name"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: fNameCon,
                  hintText: "Alex",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Last Name"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: lNameCon,
                  hintText: "Wright",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Password"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: passwordCon,
                  hintText: "*******",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Shop Name"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: shopNameCon,
                  hintText: "Johny Hardware Store",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("Shop Address"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: shopAddressCon,
                  hintText: "123 Main Street, New York, NY 10030",
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldLabel("About"),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: aboutCon,
                  validator: requiredValidator,
                  hintText: "I'm known for well-organized team player.",
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    decoration: BoxDecoration(
                      border: Border.all(color: buttonBorderColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 46,
                    child: MaterialButton(
                      elevation: 0,
                      highlightElevation: 0,
                      color: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        if(_uForm.currentState!.validate())
                          {
                             updatedData();
                          }
                        else{
                          print("Something is wrong!");
                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: buttonTextColor,
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
      ),
    );
  }
}
