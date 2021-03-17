import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

enum AvailableColors { orange, blue, pink }
Color getColor(AvailableColors availableColors) {
  switch (availableColors) {
    case AvailableColors.orange:
      return orange;
      break;
    case AvailableColors.blue:
      return Color(0xff6FF3F8);
      break;
    case AvailableColors.pink:
      return Color(0xffD981F9);
      break;
    default:
      return orange;
  }
}

class ThemeColor extends GetxController {
  var main = getColor(AvailableColors.orange).obs;
  setTheme(AvailableColors availableColors) {
    main.value = getColor(availableColors);
  }
}

Color blueDark = Color(0xff1E2140);
Color black = Color(0xff151932);
Color blue = Color(0xff262A57);
Color orange = Color(0xffF87070);
Color white = Color(0xffD7E0FF);
TextStyle header =
    GoogleFonts.rubik(fontSize: 28, fontWeight: FontWeight.w600, color: white);
TextStyle time = GoogleFonts.rubik(
    fontSize: 84,
    fontWeight: FontWeight.w600,
    color: white,
    letterSpacing: 2.2);
TextStyle subtitle1 =
    GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.w500, color: white);
TextStyle tabLabel =
    GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w600, color: white);
