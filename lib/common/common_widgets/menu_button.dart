

import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';

import 'app_text.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;

  MenuButton({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenSize(context).width - (2 * Global.mainPadding),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Resources.color.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Row(
          children: [
            imageAsset(icon, width: 24, height: 24),
            SizedBox(width: Global.mainPadding,),
            AppText(
              text,
              textStyle: Resources.textStyle.koHoSmallText(
                color: Resources.color.textColor,
                fontSize: 16,
                isBold: true,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}