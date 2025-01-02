import 'package:flutter/material.dart';

double calcuteWidth(int a, var context) {
  var sizeWidth = MediaQuery.of(context).size.width;
  return sizeWidth / (1148 / a);
}

double calcuteHeight(int a, var context) {
  var sizeHeight = MediaQuery.of(context).size.height;
  return sizeHeight / (2560 / a);
}

enum Fonts { Vazir, VazirMedium, VazirBold, VazirBlack, ExtraBold }

extension AppFontsExtension on Fonts {
  String get fontFamily {
    switch (this) {
      case Fonts.Vazir:
        return 'Vazir';
      case Fonts.VazirMedium:
        return 'VazirMedium';
      case Fonts.VazirBold:
        return 'VazirBold';
      case Fonts.VazirBlack:
        return 'VazirBlack';
      case Fonts.ExtraBold:
        return 'ExtraBold';
      default:
        return 'Vazir';
    }
  }
}

Color backgroundColor = Colors.white;
Color blackColor = Colors.black;
Color female = const Color(0xffBB3166);
Color textColor = const Color(0xff181D3F);
Color grayColor = const Color(0xff505050);
Color fillCard = const Color(0xff3B3F54).withOpacity(0);
int changeCol = 0;
List<Color> timelineColors = [
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.red,
];
List<double> timelineStops = [
  0.0,
  0.25,
  0.75,
  1.0,
];
const String url = "myket://comment?id=com.google.BMI";
