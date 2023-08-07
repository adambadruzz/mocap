import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';

InputDecoration customTextFieldDecoration(String labelText) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusColor: black,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: blueFigma, width: 3),
    ),
    labelStyle: headline3Light,
    labelText: labelText,
  );
}
