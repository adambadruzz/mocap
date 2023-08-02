import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';

Widget customIconButton(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(double.infinity),
        color: lightGreyFigma,
      ),
      child: Icon(
        icon,
        color: blueFigma,
      ),
    ),
  );
}
