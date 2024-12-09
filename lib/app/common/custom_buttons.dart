import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../constant/app_shape.dart';

class CustomButton {
  // Static method to create a button with customizable corner shape
  static Widget button({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = true,
    double padding = 16.0,
    double? height = 40.0,
    Color? backgroundColor,
    Color? textColor,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.bold,
    IconData? icon,
    double iconSize = 24.0,
    Color? iconColor,
    BorderRadius? shape = AppShape.allCorners, // Shape param with default to allCorners
  }) {
    return ElevatedButton.icon(
      
      onPressed: onPressed,
      icon: icon != null
          ? Icon(
              icon,
              size: iconSize,
              color: iconColor ?? (isPrimary ? Colors.white : Colors.black),
            )
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor ?? (isPrimary ? Colors.white : Colors.black),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(padding),
        backgroundColor:
            backgroundColor ?? (isPrimary ? AppColors.primary : Colors.grey[200]),
        shape: RoundedRectangleBorder(
          borderRadius: shape ?? AppShape.allCorners, // Use the provided shape or the default one
        ),
      ),
    );
  }
}
