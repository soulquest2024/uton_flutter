

import 'package:flutter/cupertino.dart';
import 'package:uton_flutter/common/app_constant.dart';

class AppText extends StatelessWidget {
  final String? text;
  final double size;
  final Color? color;
  final bool bold;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final String? fontFamily;
  final bool semiBold;
  final bool underlined;
  final bool isLineThrough;
  final bool italic;
  final int maxLines;
  final double? maxWidth;
  final FontWeight? fontWeight;

  const AppText(
      this.text,
      { this.size = 16,
        this.color,
        this.bold = false,
        this.textAlign = TextAlign.start,
        this.textStyle,
        this.fontFamily,
        this.semiBold = false,
        this.underlined = false,
        this.isLineThrough = false,
        this.italic = false,
        this.maxLines = 1000,
        this.maxWidth = double.infinity,
        this.fontWeight,
        Key? key
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: (maxWidth != null) ? BoxConstraints(maxWidth: maxWidth!) : null,
        child: Text(
            text ?? "",
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: textStyle ?? Resources.textStyle.koHoSmallText()
        )
    );
  }
}