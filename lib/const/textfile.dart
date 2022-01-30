import 'package:flutter/material.dart';

InputDecoration textfileStyle(String labelText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    labelText: labelText,
    filled: true,
    // fillColor: AppColors.deep_orange,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: const BorderSide(
      //   color: AppColor.appMainColor,
      //   width: 2,
      // ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: const BorderSide(
      //   color: AppColor.appMainColor,
      //   width: 2,
      // ),
    ),
  );
}