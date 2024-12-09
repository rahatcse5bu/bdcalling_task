import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_shape.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final bool? isStack;
  final Widget? topRight;
  final Widget? topLeft;
  final Widget? bottomLeft;
  final Widget? bottomRight;
  final String? description;
  final double? elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? customShape; // Accept AppShape for custom shape

  final List<BoxShadow>? boxShadow;
  final Widget? child; // The new child widget parameter

  const CustomCard({
    Key? key,
    this.title,
    this.description,
    this.isStack,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.customShape,
    this.boxShadow,
    this.child, // Accept a dynamic child widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detect current theme mode
    final isDarkMode = Get.isDarkMode;

    return Stack(
      children: [
        Container(
          margin: margin ?? EdgeInsets.all(8),
          decoration: ShapeDecoration(
            // color: Colors.red,
            color: backgroundColor ??
                (isDarkMode ? Colors.grey[800] : Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: customShape ??
                  AppShape.allCorners, // Use customShape or default AppShape
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0,
              ),
            ),
            shadows: boxShadow ??
                [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black54
                        : Colors.grey.withOpacity(0.5),
                    blurRadius: elevation ?? 8,
                    offset: Offset(0, 4),
                  ),
                ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // If child is provided, wrap it in a container with padding
                  if (child != null) ...[
                    Padding(
                      padding:
                          padding ?? EdgeInsets.all(8), // Apply padding here
                      child: child!, // Display the dynamic content
                    ),
                  ],
                ],
              ),
              if (isStack == true && topLeft!=null )
                Positioned(top: 0, left: 0, child: topLeft ?? Container()),
              if (isStack == true  && topRight!=null)
                Positioned(top: 0, right: 0, child: topRight ?? Container()),
              if (isStack == true  && bottomLeft!=null)
                Positioned(
                    bottom: 0, left: 0, child: bottomLeft ?? Container()),
              if (isStack == true  && bottomRight!=null)
                Positioned(
                    bottom: 0, right: 0, child: bottomRight ?? Container()),
            ],
          ),
        ),
      ],
    );
  }
}
