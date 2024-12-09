import 'package:flutter/material.dart';

class AppShape {
  // Custom Top-Left, Top-Right, Bottom-Left, Bottom-Right Corner Radius
  static BorderRadius topLeftCorner = BorderRadius.only(
    topLeft: Radius.circular(15),
  );

  static BorderRadius topRightCorner = BorderRadius.only(
    topRight: Radius.circular(15),
  );

  static BorderRadius bottomLeftCorner = BorderRadius.only(
    bottomLeft: Radius.circular(15),
  );

  static BorderRadius bottomRightCorner = BorderRadius.only(
    bottomRight: Radius.circular(15),
  );

  // Custom All Corners
   static const BorderRadius allCorners = BorderRadius.all(Radius.circular(15));

  // Custom Specific Corners: Example - Top-Left and Bottom-Right
  static BorderRadius topLeftBottomRightCorner = BorderRadius.only(
    topLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
  );

  // Custom Specific Corners: Example - Top-Right and Bottom-Left
  static BorderRadius topRightBottomLeftCorner = BorderRadius.only(
    topRight: Radius.circular(15),
    bottomLeft: Radius.circular(15),
  );

  // Custom Circle Shape (for round edges)
  static BoxShape circle = BoxShape.circle;
}
