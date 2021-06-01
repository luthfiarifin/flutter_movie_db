import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Note: Colors
Color primaryColor = Color(0xff181421);
Color redColor = Color(0xfffa0000);
Color whiteColor = Color(0xffffffff);
Color grayColor = Color(0xff747479);

// Note: Fonts
TextStyle tsTitle1 = GoogleFonts.poppins(
  color: whiteColor,
  fontWeight: medium,
  fontSize: 20
);
TextStyle tsTitle2 = GoogleFonts.poppins(
  color: whiteColor,
  fontWeight: light,
  fontSize: 16
);
TextStyle tsTitle3 = GoogleFonts.poppins(
  color: whiteColor,
  fontWeight: light,
  fontSize: 14
);
TextStyle tsSubtitle = GoogleFonts.poppins(
  color: grayColor,
  fontWeight: light,
  fontSize: 12
);

// Note: Font Weights
FontWeight light = FontWeight.w300;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w700;
