

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/common_widgets/menu_button.dart';
import 'package:uton_flutter/common/common_widgets/shrine_menu_button.dart';
import 'package:uton_flutter/common/enums.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';
import 'package:uton_flutter/settings/profile/profile_screen.dart';

class ShrineScreen extends StatelessWidget {
  const ShrineScreen({super.key});

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
        Center(child: AppText("shrine_title".tr(), textStyle: Resources.textStyle.koHoTitleText(), textAlign: TextAlign.center,)),
        SizedBox(height: Global.mainPadding,),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Global.mainPadding, vertical: Global.mainPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.greeting,
                        shrineMenuSizeType: ShrineMenuSizeType.small,
                      ),
                      SizedBox(width: Global.smallPadding),
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.history,
                        shrineMenuSizeType: ShrineMenuSizeType.large,
                      ),
                    ],
                  ),
                  SizedBox(height: Global.smallPadding),
                  Row(
                    children: [
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.programs,
                        shrineMenuSizeType: ShrineMenuSizeType.large,
                      ),
                      SizedBox(width: Global.smallPadding),
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.contact,
                        shrineMenuSizeType: ShrineMenuSizeType.small,
                      ),
                    ],
                  ),
                  SizedBox(height: Global.smallPadding),
                  Row(
                    children: [
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.images,
                        shrineMenuSizeType: ShrineMenuSizeType.small,
                      ),
                      SizedBox(width: Global.smallPadding),
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.game,
                        shrineMenuSizeType: ShrineMenuSizeType.large,
                      ),
                    ],
                  ),
                  SizedBox(height: Global.smallPadding),
                  Row(
                    children: [
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.hotels,
                        shrineMenuSizeType: ShrineMenuSizeType.medium,
                      ),
                      SizedBox(width: Global.smallPadding),
                      ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator<ProfileScreen>(),
                          ),
                        );
                      },
                        shrineMenuType: ShrineMenuType.restaurants,
                        shrineMenuSizeType: ShrineMenuSizeType.medium,
                      ),
                    ],
                  ),
                  SizedBox(height: Global.smallPadding),
                  ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => locator<ProfileScreen>(),
                      ),
                    );
                  },
                    shrineMenuType: ShrineMenuType.attractions,
                    shrineMenuSizeType: ShrineMenuSizeType.full,
                  ),
                  SizedBox(height: Global.smallPadding),
                  ShrineMenuButton(text: "profile_title".tr(), icon: "tabProfile.png", onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => locator<ProfileScreen>(),
                      ),
                    );
                  },
                    shrineMenuType: ShrineMenuType.booking,
                    shrineMenuSizeType: ShrineMenuSizeType.full,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
    // For example, clear user session and navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}