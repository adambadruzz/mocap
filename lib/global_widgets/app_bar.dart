import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(title, style: headline2),
    centerTitle: true,
    iconTheme: const IconThemeData(color: black),
  );
}
