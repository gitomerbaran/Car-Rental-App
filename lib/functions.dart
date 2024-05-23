import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color appBarColor = Colors.red;
TextStyle fonts = GoogleFonts.roboto();
TextStyle calendarFunction(double fontsize, FontWeight fontWeight) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(fontSize: fontsize, fontWeight: fontWeight),
  );
}
