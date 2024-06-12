import 'package:flutter/material.dart';

import '../helper/constant.dart';


Widget textFieldLabel(String label) {
  return Text(
    "$label",
    style: TextStyle(
      color: KPrimaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
