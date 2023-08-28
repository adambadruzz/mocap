import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';

Widget customIconButton(String image, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(double.infinity),
        color: lightGreyFigma,
      ),
      child: Image.asset(
        image,
        height: 20,
        width: 20,
      ),
    ),
  );
}
