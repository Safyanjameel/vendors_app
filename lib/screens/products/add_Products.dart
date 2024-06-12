import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/validators.dart';
import '../../helper/constant.dart';
import '../../widget/headings.dart';
import '../../widget/myTextField.dart';
import '../alert_Dialouges/product_successfuly_Added.dart';
import '../utils/singleton.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _companyCon = TextEditingController();
  TextEditingController _productNameCon = TextEditingController();
  TextEditingController _productKindCon = TextEditingController();
  TextEditingController _productDesCon = TextEditingController();
  TextEditingController _priceCon = TextEditingController();
  TextEditingController _cityCon = TextEditingController();
  TextEditingController _districtCon = TextEditingController();

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  File? _pickedImage;

  Future myProductImage() async {
    PickedFile image =
    await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(image.path);
    });
  }

  Future<String> uploadImage(File images) async {
    String img;
    Reference ref = _firebaseStorage
        .ref()
        .child("Product/Product Images/${DateTime.now().toString()}");
    UploadTask uploadTask = ref.putFile(images);
    TaskSnapshot snapshot = await uploadTask;
    String imgUrl = await snapshot.ref.getDownloadURL();
    img = imgUrl.toString();
    return img;
  }

  Future<void> uploadProduct() async {
    String productImage = await uploadImage(_pickedImage!);
    String addedDate = DateTime.now().toString();
    try {
      var id = Timestamp.now().millisecondsSinceEpoch.toString();
      await _firebaseFirestore.collection("Products").doc(id).set({
        "Product Image": productImage,
        "Email Address": UserSingleton.userData.email,
        "Company": _companyCon.text.trim(),
        "Product Name": _productNameCon.text.trim(),
        "Product Type": _productKindCon.text.trim(),
        "Product Description": _productDesCon.text.trim(),
        "Price": _priceCon.text.trim(),
        "City": _cityCon.text.trim(),
        "District": _districtCon.text.trim(),
        "Added Date": addedDate,
      }).then((value) {
        setState(() {
          _pickedImage = null;
        });
        _productNameCon.clear();
        _companyCon.clear();
        _productKindCon.clear();
        _productDesCon.clear();
        _priceCon.clear();
        _cityCon.clear();
        _districtCon.clear();
      }).then((value) => Get.dialog(ProductSuccessfullyAdded()));
    } catch (e) {
      print("This is exception $e");
    }
  }

  GlobalKey<FormState> _aP = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KSecondaryColor,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Rectangle 11.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: KPrimaryColor.withOpacity(0.85),
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
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
          "Add Product",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: KWhiteColor),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _aP,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                textFieldLabel("Upload Image"),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => myProductImage(),
                  child: DottedBorder(
                    radius: Radius.circular(5),
                    color: KPrimaryColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: _pickedImage == null
                            ? Center(child: Icon(Icons.add))
                            : Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: Get.height,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("Company"),
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _companyCon,
                  validator: requiredValidator,
                  hintText: "Type the company name",
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("Product Name"),
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _productNameCon,
                  hintText: "What are you selling?",
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("What type of your product is?"),
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _productKindCon,
                  hintText: "Room air unit",
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("City"),
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _cityCon,
                  hintText: "Sahiwal",
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("District"),
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _districtCon,
                  hintText: "Punjab",
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("Product Description"),
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                  validator: requiredValidator,
                  controller: _productDesCon,
                  hintText: "Tell your buyer about what they are buying.",
                  maxLines: 4,
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldLabel("Price"),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: KWhiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    validator: requiredValidator,
                    controller: _priceCon,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: KPrimaryColor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          color: KPrimaryColor.withOpacity(0.5),
                        ),
                        width: 59,
                        child: Center(
                          child: Image.asset(
                            'assets/Selected.png',
                            height: 18,
                          ),
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                //Button
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: 48,
                    child: MaterialButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: KPrimaryColor,
                      textColor: KWhiteColor,
                      onPressed: ()  {
                        if(_aP.currentState!.validate()){
                          uploadProduct();
                        }
                        else{
                          print("Something is wrong!");
                        }
                      },
                      child: Text("Done".toUpperCase()),
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
