

import 'package:flutter/material.dart';

Widget imageAsset(String? fileName, {String baseFolder = "assets/images/", double? width, double? height,
  Widget? errorWidget, BlendMode? colorBlendMode, Color? color, BoxFit? fit, double topLeftR = 0.0,
  double topRightR = 0.0, double bottomLeftR = 0.0, double bottomRightR = 0.0, String? semanticLabel }) {
  if(fileName == null || fileName.isEmpty) {
    return errorWidget ?? SizedBox(width: width, height: height);
  }

  return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftR),
          topRight: Radius.circular(topRightR),
          bottomLeft: Radius.circular(bottomLeftR),
          bottomRight: Radius.circular(bottomRightR)
      ),
      child: Image.asset(baseFolder + fileName, width: width, height: height, colorBlendMode: colorBlendMode, color: color, fit: fit,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return errorWidget ?? SizedBox(width: width, height: height);
        },
        semanticLabel: semanticLabel,
      ));
}

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

