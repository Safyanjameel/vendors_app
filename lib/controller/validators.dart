import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:vendors_app/controller/sign_Up_Controller.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Passwords must have at least one special character')
]);

final requiredValidator = RequiredValidator(errorText: 'Field is required');
final emailValidator =  EmailValidator(errorText: 'Enter a valid email address');
