
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Resources.color.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: AppText(
          text,
          textStyle: Resources.textStyle.koHoSmallText(
            color: Resources.color.textColor,
            fontSize: 16,
            isBold: true,
          ),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }
}