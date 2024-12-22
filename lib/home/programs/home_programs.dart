
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/animation_widget.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/models/offer.dart';
import 'package:uton_flutter/common/models/program.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';
import 'package:uton_flutter/providers/home_provider.dart';
import 'package:uton_flutter/providers/image_provider.dart';

class HomePrograms extends StatefulWidget {

  HomePrograms({Key? key}) : super(key: key);

  @override
  _HomeProgramsState createState() => _HomeProgramsState();
}

class _HomeProgramsState extends State<HomePrograms> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, provider, child) {
          final programState = provider.programs;
          if (programState?.status == ApiStatus.LOADING) {
            return Center(child: AnimationWidget());
          } else if (programState?.status == ApiStatus.ERROR) {
            return Center(child: Text("Egyetlen betű sem érkezett"));
          } else {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 200,
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: (programState?.data ?? []).length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider(
                    create: (_) => ImageNotifier(),
                    child: HomeProgramItem(program: (programState?.data ?? [])[index]));
                },
              ),
            );
          }
        }
    );
  }
}

class HomeProgramItem extends StatelessWidget {
  final Program program;

  HomeProgramItem({Key? key, required this.program})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageNotifier = context.watch<ImageNotifier>();
    if(!imageNotifier.isLoading && imageNotifier.image == null && imageNotifier.errorMessage == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        imageNotifier.loadImage(program.image ?? "");
      });
    }
    return Padding(
      padding: const EdgeInsets.all(Global.mainPadding),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: Resources.color.thirdColor.withOpacity(0.1),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(
              10), // Set the border radius to 10 pixels
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          // Also set the border radius here
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
                          ? imageNotifier.image ?? Container()
                          : imageAsset('logo_transparent.png', width: 120, height: 120),
                    ),
                    Container(
                      width: getScreenSize(context).width - 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(program.title ?? "",
                              textStyle: Resources.textStyle.koHoSmallText(
                                  color: Resources.color.textColor,
                                  fontSize: 16,
                                  isBold: true), textAlign: TextAlign.end,),
                          const Spacer(),
                          AppText(program.date ?? "",
                              textStyle: Resources.textStyle.koHoSmallLightText(
                                  color: Resources.color.textColor,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
