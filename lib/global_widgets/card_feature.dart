import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';

Widget cardFeature(String imgUrl, title, desc, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: lightGreen,
          boxShadow: [imageShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgUrl),
                    fit: BoxFit.cover)),
          ),
          Text(title, style: headline3),
          const SizedBox(height: 8),
          Text(desc, style: paragraphRegular),
        ],
      ),
    ),
  );
}
