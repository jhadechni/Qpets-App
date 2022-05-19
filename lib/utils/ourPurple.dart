import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor ourPurple = MaterialColor(
    0xFF7F77C6, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x008064c2), //10%
      100: Color(0x007259ad), //20%
      200: Color(0x00634e97), //30%
      300: Color(0x00554382), //40%
      400: Color(0x0047386c), //50%
      500: Color(0x00392c56), //60%
      600: Color(0x002b2141), //70%
      700: Color(0x001c162b), //80%
      800: Color(0x000e0b16), //90%
      900: Color(0x00000000), //100%
    },
  );
}