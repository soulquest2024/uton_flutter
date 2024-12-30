
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/common_widgets/menu_button.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';
import 'package:uton_flutter/settings/profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
      [
        imageAsset("background.png", fit: BoxFit.fitWidth, width: getScreenSize(context).width, height: getScreenSize(context).height),
        _mainContent(context)
      ],
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(child: AppText("settings_title".tr(), textStyle: Resources.textStyle.koHoTitleText(), textAlign: TextAlign.center,)),
        SizedBox(height: Global.mainPadding,),
        MenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => locator<ProfileScreen>(),
            ),
          );
        }),
        MenuButton(text: "logout_button".tr(), icon: "logout.png", onPressed: () {

        }),
      ],
    );
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
    // For example, clear user session and navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}