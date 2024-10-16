import 'package:chattick/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class style{
  static double _fontSize(double size, BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    if (deviceWidth >= 1900) {
      return size * 1.2;
    } else if (deviceWidth >= 1500) {
      return size * 1.1;
    } else if (deviceWidth >= 1000) {
      return size * 1.0;
    } else if (deviceWidth >= 900) {
      return size * 0.9;
    } else if (deviceWidth >= 600) {
      return size * 0.8;
    } else {
      return size;     }
  }

  TextStyle TheBigHead(BuildContext context) {
    return GoogleFonts.mulish(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color:Coloure.BigHead,
      ),
    );
  }
 static TextStyle TheSmallHead(BuildContext context) {
    return GoogleFonts.mulish(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color:Coloure.SmalHead,

      ),
    );
  }
  static TextStyle FeildInput(BuildContext context) {
    return GoogleFonts.mulish(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color:Coloure.FeildText,

      ),
    );
  }
  static  TextStyle UserName (BuildContext context) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color:Coloure.UserName,

      ),
    );
  }
}