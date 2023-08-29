import 'package:flutter/material.dart';

const black = Color(0xFF171D1C);
const white = Color(0xFFFFFFFF);
const darkGreen = Color(0xFF40a475);
const earieBlack = Color(0xFF171D1C);
const lightBlack = Color(0xFF666969);
const extraDarkGreen = Color(0xFF245E56);
const redDanger = Color(0xFFC75A4C);
const extraLightGrey = Color(0xFFF6F6F6);
const lightGreen = Color(0xFFEDFCF5);
const lightGrey = Color(0xFFF6F6F6);

// NEW FROM FIGMA
// Color
const blackFigma = Color(0xFF171D1C);
const greyFigma = Color(0xFF666969);
const blueFigma = Color(0xFF4080A4);
const darkGreenFigma = Color(0xFF24575E);
const lightGreyFigma = Color(0xFFF6F6F6);
const lightGreenFigma = Color(0xFFEDFCF5);
const lightRedFigma = Color(0xFFFCEDED);

// Font
const headline1 = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  color: darkGreenFigma,
);

const headline2 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: black,
);

const headline2Light = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  color: black,
);

const headline3 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: black,
);

const headline3Light = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: black,
);

const paragraph = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: black,
);

const paragraphRegular = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: black,
);

const paragraphMedium = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: black,
);

TextStyle customTextStyle(size, weight, color) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}

// Shadow
final cardShadow = BoxShadow(
  color: black.withOpacity(0.1),
  blurRadius: 9,
  offset: const Offset(0, 4), // changes position of shadow
);

final cardShadowSmall = BoxShadow(
  color: black.withOpacity(0.1),
  blurRadius: 9,
  offset: const Offset(0, 2), // changes position of shadow
);

final imageShadow = BoxShadow(
  color: black.withOpacity(0.2),
  blurRadius: 4,
  offset: const Offset(2, 2), // changes position of shadow
);

final buttonShadow = BoxShadow(
  color: black.withOpacity(0.2),
  blurRadius: 8,
  offset: const Offset(1, 4), // changes position of shadow
);

final headerShadow = BoxShadow(
  color: black.withOpacity(0.1),
  blurRadius: 14,
  offset: const Offset(0, 1), // changes position of shadow
);

// Padding
const paddingS = 8.0;
const paddingM = 16.0;
const paddingL = 24.0;
