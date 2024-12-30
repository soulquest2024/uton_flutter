


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/enums.dart';

import 'app_text.dart';

class ShrineMenuButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;
  final ShrineMenuType shrineMenuType;
  final ShrineMenuSizeType shrineMenuSizeType;

  ShrineMenuButton({required this.text, required this.icon, required this.onPressed, required this.shrineMenuType, required this.shrineMenuSizeType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _calculateButtonWidth(context),
      height: Global.mainButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _settingColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Global.mainCornerRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: Global.smallPadding), // Padding módosítása
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageAsset(_settingIcon(), width: 32, height: 32),
            AppText(
              _settingTitle(),
              textStyle: Resources.textStyle.koHoSmallText(
                color: Resources.color.textColor,
                fontSize: 16,
                isBold: true,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  double _calculateButtonWidth(BuildContext context) {
    switch (shrineMenuSizeType) {
      case ShrineMenuSizeType.small:
        return (getScreenSize(context).width - (2 * Global.mainPadding + Global.smallPadding)) / 3;
      case ShrineMenuSizeType.medium:
        return (getScreenSize(context).width - (2 * Global.mainPadding + Global.smallPadding)) / 2;
      case ShrineMenuSizeType.large:
        return (getScreenSize(context).width - (2 * Global.mainPadding + Global.smallPadding)) / 3 * 2;
      case ShrineMenuSizeType.full:
        return getScreenSize(context).width - (2 * Global.mainPadding);
    }
  }

  Color _settingColor() {
    switch (shrineMenuType) {
      case ShrineMenuType.greeting:
        return Resources.color.softSunriseColor;
      case ShrineMenuType.history:
        return Resources.color.blushPetalColor;
      case ShrineMenuType.programs:
        return Resources.color.mintBreezeColor;
      case ShrineMenuType.contact:
        return Resources.color.peachWhisperColor;
      case ShrineMenuType.images:
        return Resources.color.lavenderDreamColor;
      case ShrineMenuType.game:
        return Resources.color.creamCloudColor;
      case ShrineMenuType.hotels:
        return Resources.color.coralGlowColor;
      case ShrineMenuType.restaurants:
        return Resources.color.aquaMistColor;
      case ShrineMenuType.attractions:
        return Resources.color.softSunriseColor;
      case ShrineMenuType.booking:
        return Resources.color.blushPetalColor;
    }
  }

  String _settingIcon() {
    switch (shrineMenuType) {
      case ShrineMenuType.greeting:
        return "shrineGreeting.png";
      case ShrineMenuType.history:
        return "shrineHistory.png";
      case ShrineMenuType.programs:
        return "shrinePrograms.png";
      case ShrineMenuType.contact:
        return "shrineContacts.png";
      case ShrineMenuType.images:
        return "shrineImages.png";
      case ShrineMenuType.game:
        return "shrineGame.png";
      case ShrineMenuType.hotels:
        return "shrineHotels.png";
      case ShrineMenuType.restaurants:
        return "shrineRestaurants.png";
      case ShrineMenuType.attractions:
        return "shrineAttractions.png";
      case ShrineMenuType.booking:
        return "shrineBooking.png";
    }
  }

  String _settingTitle() {
    switch (shrineMenuType) {
      case ShrineMenuType.greeting:
        return "shrine_greeting".tr();
      case ShrineMenuType.history:
        return "shrine_history".tr();
      case ShrineMenuType.programs:
        return "shrine_programs".tr();
      case ShrineMenuType.contact:
        return "shrine_contact".tr();
      case ShrineMenuType.images:
        return "shrine_gallery".tr();
      case ShrineMenuType.game:
        return "shrine_game".tr();
      case ShrineMenuType.hotels:
        return "shrine_hotels".tr();
      case ShrineMenuType.restaurants:
        return "shrine_restaurants".tr();
      case ShrineMenuType.attractions:
        return "shrine_attractions".tr();
      case ShrineMenuType.booking:
        return "shrine_booking".tr();
    }
  }
}