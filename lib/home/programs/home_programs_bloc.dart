
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:uton_flutter/common/api/api_resource.dart';
import 'package:uton_flutter/common/api/bloc.dart';
import 'package:uton_flutter/common/firestore/firestore_database.dart';

class HomeProgramsBloc extends Bloc<ApiResource<String>> {

  Future<Widget> downloadImage(String storageLocation) async {
    Uint8List imageData = await FirestoreDatabase.shared.downloadImage(storageLocation);
    return Image.memory(
      imageData,
      fit: BoxFit.fitHeight,
    );
  }

  @override
  void dispose() {

  }
}