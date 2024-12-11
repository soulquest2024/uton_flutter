

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/firestore/firestore_database.dart';
import 'package:uton_flutter/common/models/offer.dart';
import 'dart:typed_data';

import 'offers_bloc.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

  late OffersBloc _bloc;
  List<Offer> _offers = [];

  @override
  void initState() {
    super.initState();
    _bloc = OffersBloc();

    _bloc.getStream<ApiResource<List<Offer>>>(name: _bloc.offersKey)?.listen((event) {
      if(event.status == ApiStatus.LOADING) {
        // show loading
      } else if(event.status == ApiStatus.SUCCESS) {
        String image = "${event.data?[0].image ?? ''}.png";



        debugPrint("offers: ${event.data?[0].image}");
        setState(() {
          _offers = event.data ?? [];
        });
      } else if(event.status == ApiStatus.ERROR) {
        // show error
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText("Ajánlatok", textStyle: Resources.textStyle.koHoTitleText()),
      ),
      body: Center(
        child: _offers.isEmpty
            ? const CircularProgressIndicator() // Loading spinner
            : ListView.builder(
          itemCount: _offers.length,
          itemBuilder: (context, index) {
            Offer offer = _offers[index];
            debugPrint("Image: ${offer.image}");
            return Stack(
              children: [
                FutureBuilder<Uint8List>(
                  future: FirestoreDatabase.shared.downloadImage(offer.image ?? ''),
                  builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Loading spinner
                    } else if (snapshot.hasError) {
                      return Text('Hiba: ${snapshot.error}');
                    } else {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
                ListTile(
                  title: AppText(offer.title ?? '', textStyle: Resources.textStyle.koHoSmallText(color: Colors.white, isBold: true, fontSize: 18),),
                  subtitle: AppText(offer.date ?? '', textStyle: Resources.textStyle.koHoSmallText(color: Colors.white, isBold: true, fontSize: 18),),
                  // Add more fields of the Offer object if needed
                )],
            );
          },
        ),
      ),
    );
  }
}

