import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';

Widget button(IconData icon, String text, bool isDanger, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightGreyFigma,
          boxShadow: [buttonShadow]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDanger ? lightRedFigma : lightGreenFigma,
            ),
            child: Icon(
              icon,
              color: isDanger ? redDanger : blueFigma,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
