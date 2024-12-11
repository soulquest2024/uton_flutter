

import 'package:flutter/material.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/api/bloc.dart';
import 'package:uton_flutter/common/firestore/firestore_database.dart';
import 'package:uton_flutter/common/models/offer.dart';


class HomeBloc extends Bloc<ApiResource<String>> {

  final String offersKey = "offersKey";

  HomeBloc() {
    addStream<ApiResource<List<Offer>>>(offersKey);
    _init();
  }

  Future<void> _init() async {

    await _getOffers();
  }

  Future<void> _getOffers() async {
    getSink<ApiResource<List<Offer>>>(name: offersKey)?.add(ApiResource.loading());
    await FirestoreDatabase.shared.getOffers()?.then((value) {
      getSink<ApiResource<List<Offer>>>(name: offersKey)?.add(ApiResource.success(value.docs.map((doc) => Offer.fromDocumentSnapshot(doc)).toList()));
    });


    /*
    try {
      _zones = (await ParkingZoneManager.shared.getUpToDateParkingZones()) ?? [];
      if(position == null) {
        getSink<ApiResource<List<Offer>>>(name: offersKey)?.add(ApiResource.success(_zones));
      } else {
        getSink<ApiResource<List<Offer>>>(name: offersKey)?.add(ApiResource.success(_zonesInRange(_zones, position, rangeInKilometers)));
      }
    } catch(e) {
      getSink<ApiResource<List<Offer>>>(name: offersKey)?.add(ApiResource.error(e.toString()));
    }
    */
  }


  Future<Widget> downloadImage(String storageLocation) async {

    FirestoreDatabase.shared.downloadImage(storageLocation).then((value) {
      return Image.memory(
        value,
        fit: BoxFit.cover,
      );
    });

    return Container();
  }

  @override
  void dispose() {

  }
}