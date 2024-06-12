import 'package:flutter/material.dart';

import '../helper/constant.dart';


class MyTextField extends StatefulWidget {
  var hintText;
  TextEditingController? controller = TextEditingController();
  bool obSecure;
  int maxLines;
  FormFieldValidator<String>? validator;

  MyTextField({
    this.hintText,
    this.controller,
    this.obSecure = false,
    this.maxLines = 1,
    this.validator,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      textCapitalization: TextCapitalization.words,
      obscureText: widget.obSecure,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: KPrimaryColor,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KBlackColor,
      ),
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        hintText: "${widget.hintText}",
      ),
    );
  }
}
