
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/string_resources.dart';

import 'local_storage.dart';

class Global {
  Global._();

  static ValueNotifier<bool> isUserLoggedIn = ValueNotifier<bool>(false);
  static const double mainPadding = 16.0;
  static const double mainCornerRadius = 8.0;

  static const Locale defaultInitialPreferredLocale = Locale("hu", '');
  static List<Locale> getSupportedLanguages() {
    return [
      Locale("hu", ''),
      Locale("en", ''),
    ];
  }

  static void navigateToLogin(BuildContext context) {
    if(Global.isUserLoggedIn.value == false && context.mounted) {
      try {
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> r) => false);
      } catch (e) {
        print(e);
      }
    }
  }
}


class Resources {
  Resources();
  static BuildContext? context;
  static AppColor color = AppColor._();
  static CustomTextStyle textStyle = CustomTextStyle._();
  static StringRes string = StringRes();

  static BoxDecoration boxDecoration({double radius = 6, Color bgColor = Colors.white, Color borderColor = Colors.white, Border? border}) {
    return BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)), border: border ?? Border.all(width: 2, color: borderColor)
    );
  }
}


class AppColor {
  AppColor._();

  Color textColor = const Color.fromRGBO(00, 03, 00, 1);
  Color primaryColor = const Color.fromRGBO(170, 87, 250, 0.4);
  Color secondaryColor = const Color.fromRGBO(226, 140, 255, 0.1);
  Color thirdColor = const Color.fromRGBO(27, 156, 250, 0.3);

  Color primaryInactiveColor = const Color.fromRGBO(240, 240, 240, 1);
  Color hintTextColor = const Color.fromRGBO(150, 150, 150, 1);


  Color blackWithOpacity(double opacity) {
    return textColor.withOpacity(opacity);
  }

  Gradient get yellowHorizontalGradient {
    return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromRGBO(220, 244, 15, 0),
          Color.fromRGBO(220, 244, 15, 0.14),
        ]
    );
  }
}

class CustomTextStyle {
  CustomTextStyle._();

  static const String koHoFont = "KoHo";

  TextStyle getTextStyle({
    String koHoFontFamily = koHoFont,
    bool isBold = false,
    bool isSemiBold = false,
    bool isUnderlined = false,
    bool isItalic = false,
    bool isLineThrough = false,
    double fontSize = 15,
    Color color = Colors.black,
    FontWeight? fontWeight
  }) {
    FontWeight weight = FontWeight.w500;
    if(isSemiBold) {
      weight = FontWeight.w600;
    }
    if(isBold) {
      weight = FontWeight.w800;
    }
    if(fontWeight != null) {
      weight = fontWeight;
    }
    TextDecoration? textDecoration;
    if(isUnderlined) {
      textDecoration = TextDecoration.underline;
    }
    if(isLineThrough) {
      textDecoration = TextDecoration.lineThrough;
    }
    return TextStyle(
        fontWeight: weight,
        fontSize: fontSize,
        fontFamily: koHoFontFamily,
        color: color,
        decoration: textDecoration,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal
    );
  }

  TextStyle koHoTitleText({Color? color, bool isBold = true, double? fontSize, TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: koHoFont,
      fontSize: fontSize ?? 32,
      fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
      color: color ?? Resources.color.textColor,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  TextStyle koHoSmallText({Color? color, bool isBold = false, FontWeight fontWeight = FontWeight.w400, double? fontSize, TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: koHoFont,
      fontSize: fontSize ?? 16,
      fontWeight: isBold ? FontWeight.bold : fontWeight,
      color: color ?? Resources.color.textColor,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  TextStyle koHoSmallLightText({Color? color, bool isBold = false, FontWeight fontWeight = FontWeight.w200, double? fontSize, TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: koHoFont,
      fontSize: fontSize ?? 16,
      fontWeight: isBold ? FontWeight.bold : fontWeight,
      color: color ?? Resources.color.textColor,
      decoration: decoration ?? TextDecoration.none,
    );
  }
}

class Shadows {
  Shadows._();
  List<BoxShadow> inputShadow = [const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 4), blurRadius: 10, spreadRadius: 0)];
  List<BoxShadow> cardShadow = [const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0, 4), blurRadius: 14, spreadRadius: 0)];
  List<BoxShadow> bottomNavBarShadow = [const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0, -4), blurRadius: 14, spreadRadius: 0)];

  BoxDecoration shadowBoxDecoration({
    double radius = 30,
    Color bgColor = Colors.white,
    double blurRadius = 10,
    Offset offset = const Offset(1, 3),
    Border? border,
  }) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          blurRadius: blurRadius,
          offset: offset, // changes position of shadow
        ),
      ],
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
      border: border,
    );
  }
}



class App {
  App._();

  static BuildContext? context;
  static void Function()? updateApp;
  static ValueNotifier<Locale> language = ValueNotifier<Locale>(
      getDefaultSupportedLanguage());

  static Future<void> changeLanguage(Locale newLanguage) async {
    await LocalStorage.shared.saveString(
        LocalStorageKeys.selectedLanguageCodeKey, newLanguage.languageCode);
    language.value = newLanguage;
    updateApp?.call();
  }

  static Locale getDeviceLanguage() {
    List<Locale> systemLocales = window.locales;
    if (systemLocales.isNotEmpty) {
      return systemLocales[0];
    } else {
      return Global.defaultInitialPreferredLocale;
    }
  }

  static Locale getDefaultSupportedLanguage() {
    Locale defaultLanguage = Global.defaultInitialPreferredLocale;
    final Locale currentDeviceLanguage = getDeviceLanguage();
    for (Locale supportedLocale in Global.getSupportedLanguages()) {
      if (supportedLocale.languageCode == currentDeviceLanguage.languageCode) {
        defaultLanguage = supportedLocale;
      }
    }
    return defaultLanguage;
  }
}

