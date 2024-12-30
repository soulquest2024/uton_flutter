

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/animation_widget.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/common_widgets/webview_screen.dart';
import 'package:uton_flutter/common/models/offer.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';
import 'package:uton_flutter/providers/home_provider.dart';
import 'package:uton_flutter/providers/image_provider.dart';

class HomeOffers extends StatefulWidget {

  const HomeOffers({Key? key}) : super(key: key);

  @override
  _HomeOffersState createState() => _HomeOffersState();
}

class _HomeOffersState extends State<HomeOffers> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = locator<HomeProvider>();
    final offersState = homeProvider.offers;
    if(offersState.status == ApiStatus.loading) {
      return Center(child: AnimationWidget());
    } else if(offersState.status == ApiStatus.error) {
      return Center(child: Text("Egyetlen betű sem érkezett"));
    } else {
      return Container(
        height: MediaQuery.of(context).size.height - 200, // 80% of screen height
        color: Colors.transparent,
        child: ListView.builder(
          itemCount: (offersState.data ?? []).length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider(
                create: (_) => ImageNotifier(),
                child: HomeOfferItem(offer: (offersState.data ?? [])[index])
            );
          },
        ),
      );
    }
  }
}

class HomeOfferItem extends StatefulWidget {
  final Offer offer;

  HomeOfferItem({Key? key, required this.offer}) : super(key: key);

  @override
  _HomeOfferItemState createState() => _HomeOfferItemState();
}

class _HomeOfferItemState extends State<HomeOfferItem> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final imageNotifier = context.watch<ImageNotifier>();
    if(!imageNotifier.isLoading && imageNotifier.image == null && imageNotifier.errorMessage == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        imageNotifier.loadImage(widget.offer.image ?? "");
      });
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => locator<WebViewScreen>(param1: { 'url': widget.offer.url ?? '', 'title': widget.offer.title ?? '' }),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(Global.mainPadding),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Resources.color.thirdColor.withOpacity(0.1),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: imageNotifier.isLoading
                          ? AnimationWidget()
                          : imageNotifier.image != null
                          ? ChangeNotifierProvider(
                          create: (_) => ImageNotifier(),
                          child: imageNotifier.image ?? Container()
                      )
                          : imageAsset('logo_transparent.png', width: 120, height: 120),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            widget.offer.title ?? "",
                            textStyle: Resources.textStyle.koHoSmallText(
                              color: Resources.color.textColor,
                              fontSize: 16,
                              isBold: true,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          const Spacer(),
                          AppText(
                            widget.offer.travelAgency ?? "",
                            textStyle: Resources.textStyle.koHoSmallText(
                              color: Resources.color.textColor,
                              fontSize: 14,
                              isBold: true,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          const Spacer(),
                          AppText(
                            widget.offer.date ?? "",
                            textStyle: Resources.textStyle.koHoSmallLightText(
                              color: Resources.color.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
