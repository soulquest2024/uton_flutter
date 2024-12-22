import 'package:flutter/material.dart';
import 'package:uton_flutter/common/firestore/firestore_database.dart';

class ImageNotifier extends ChangeNotifier {
  Widget? _image;
  String? _errorMessage;
  bool _isLoading = false;

  Widget? get image => _image;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> loadImage(String storageLocation) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final value = await FirestoreDatabase.shared.downloadImage(storageLocation);
      _image = Image.memory(value, fit: BoxFit.cover);

    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
