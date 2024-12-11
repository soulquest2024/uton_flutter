
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/models/offer.dart';

import 'home_programs_bloc.dart';

class HomePrograms extends StatefulWidget {
  List<Offer> offers;

  HomePrograms({Key? key, required this.offers}) : super(key: key);

  @override
  _HomeProgramsState createState() => _HomeProgramsState();
}

class _HomeProgramsState extends State<HomePrograms> {

  late HomeProgramsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeProgramsBloc();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("offers: ${widget.offers.length}");
    return Container(
      height: MediaQuery.of(context).size.height - 200, // 80% of screen height
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: widget.offers.length,
        itemBuilder: (context, index) {
          return HomeProgramItem(offer: widget.offers[index]);
        },
      ),
    );
  }
}

class HomeProgramItem extends StatelessWidget {
  final Offer offer;
  HomeProgramsBloc bloc = HomeProgramsBloc();

  HomeProgramItem({Key? key, required this.offer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    FutureBuilder<Widget>(
                      future: bloc.downloadImage(offer.image ?? ""),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),
                    Container(
                      width: getScreenSize(context).width - 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(offer.title ?? "",
                              textStyle: Resources.textStyle.koHoSmallText(
                                  color: Resources.color.textColor,
                                  fontSize: 16,
                                  isBold: true), textAlign: TextAlign.end,),
                          const Spacer(),
                          AppText(offer.location ?? "",
                              textStyle: Resources.textStyle.koHoSmallText(
                                  color: Resources.color.textColor,
                                  fontSize: 16)),
                          const Spacer(),
                          AppText(offer.date ?? "",
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
