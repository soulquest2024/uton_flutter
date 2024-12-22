import 'package:flutter/material.dart';
import 'package:uton_flutter/common/firestore/firestore_database.dart';
import 'package:uton_flutter/common/models/offer.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/models/program.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';

class HomeProvider extends ChangeNotifier {
  final FirestoreDatabase firestoreDatabase = locator<FirestoreDatabase>();
  final ApiResourceManager<List<Program>> programResourceManager = locator<ApiResourceManager<List<Program>>>();
  final ApiResourceManager<List<Offer>> offerResourceManager = locator<ApiResourceManager<List<Offer>>>();
  final ApiResourceManager<Widget> imageResourceManager = locator<ApiResourceManager<Widget>>();

  ApiResource<List<Program>>? _programs;
  late ApiResource<List<Offer>> _offers;
  late ApiResource<Widget> _image;

  ApiResource<List<Program>>? get programs => _programs;
  ApiResource<List<Offer>> get offers => _offers;
  ApiResource<Widget> get image => _image;

  HomeProvider() {
    _offers = offerResourceManager.loading();
    _image = imageResourceManager.loading();
    _init();
  }

  Future<void> _init() async {
    await _getPrograms();
    await _getOffers();
  }

  Future<void> _getPrograms() async {
    _programs = programResourceManager.loading();
    notifyListeners();
    try {
      final result = await firestoreDatabase.getPrograms();
      final programsList = result?.docs.map((doc) {
        return Program.fromDocumentSnapshot(doc);
      }).toList() ?? [];
      debugPrint("Api_STATUS1: ${_programs?.status}");
      _programs = programResourceManager.success(programsList);
      debugPrint("Api_STATUS2: ${_programs?.status}");
      notifyListeners();
    } catch (e, stackTrace) {
      debugPrint("Error in _getPrograms: $e");
      debugPrint("Stack trace: $stackTrace");
      _programs = programResourceManager.error("Error loading programs");
    }
  }

  Future<void> _getOffers() async {
    _offers = offerResourceManager.loading();
    notifyListeners();

    try {
      final result = await firestoreDatabase.getOffers();
      final offersList = result?.docs.map((doc) {
        return Offer.fromDocumentSnapshot(doc);
      }).toList() ?? [];
      _offers = offerResourceManager.success(offersList);
    } catch (e) {
      _offers = offerResourceManager.error("Error loading offers");
    }

    notifyListeners();
  }
}