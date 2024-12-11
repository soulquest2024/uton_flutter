

import 'package:flutter/cupertino.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';

class HomeOffers extends StatefulWidget {
  HomeOffers({Key? key}) : super(key: key);

  @override
  _HomeOffersState createState() => _HomeOffersState();
}

class _HomeOffersState extends State<HomeOffers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppText("Offers"),
    );
  }
}

