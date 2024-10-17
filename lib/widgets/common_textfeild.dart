import 'package:flutter/material.dart';
import 'package:tasktrack/utils/common_colors.dart';

class CommonTextFeild extends StatelessWidget {
  const CommonTextFeild({
    super.key,
    required this.hinttext,
    required this.label,
    this.suffixicon,
    this.validation = false,
    this.controller,
    this.fillColor,
    this.maxLength,
    this.textInputType,
    this.suffixIcon,
    this.onChanged,
    this.labelColor,
    this.hinttextColor,
    this.mobileNoValidater = false,
    this.emailValidation = false,
    this.maxLines,
  });
  final String hinttext;
  final String label;
  final Widget? suffixicon;
  final bool? validation;
  final Color? fillColor;
  final TextEditingController? controller;
  final int? maxLength;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Color? labelColor;
  final Color? hinttextColor;
  final bool mobileNoValidater;
  final bool emailValidation;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: textInputType,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(
          color: hinttextColor,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
        suffix: suffixicon,
        filled: true,
        fillColor: kdefWhiteColor ?? fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kTextFeildBoard,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        //mobile regex
        String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = new RegExp(mobilePattern);
        //email regex
        String emailreg = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*$';
        RegExp regex = new RegExp(emailreg);
        if (validation == true) {
          if (value == null || value.isEmpty) {
            return hinttext + 'Required';
          } else if (mobileNoValidater == true) {
            if (!regExp.hasMatch(value)) {
              return 'Please enter valid mobile number';
            }
          } else if (emailValidation == true) {
            if (!regex.hasMatch(value)) {
              return 'Please enter valid Email Address';
            }
          }
          return null;
        }
      },
      controller: controller,
    );
  }
}
