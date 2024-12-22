
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:uton_flutter/common/models/offer.dart';

class FirestoreDatabase {

  FirestoreDatabase._privateConstructor();

  static final FirestoreDatabase shared = FirestoreDatabase._privateConstructor();

  CollectionReference? programsCollection = FirebaseFirestore.instance.collection('programs');
  CollectionReference? offersCollection = FirebaseFirestore.instance.collection('offers');

  Future<QuerySnapshot>? getPrograms() {
    try {
      return programsCollection?.get();
    } catch (e) {
      debugPrint("Error getting programs: $e");
      return null;
    }
  }

  Future<QuerySnapshot>? getOffers() {
    try {
      return offersCollection?.get();
    } catch (e) {
      debugPrint("Error getting offers: $e");
      return null;
    }
  }

  Future<void> uploadOffer(Offer offer) async {
    try {
      await offersCollection?.doc(offer.id).set(offer.toJson());
      debugPrint("Upload success");
    } catch (e) {
      debugPrint("Error uploading offer: $e");
    }
  }

  Future<String> getImageUrl(String fileName) async {
    try {
      // Create a reference to the file location
      Reference ref = FirebaseStorage.instance.ref(fileName);

      // Get the download URL
      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Failed to get download URL: $e');
      return '';
    }
  }

  Future<Uint8List> downloadImage(String storageLocation) async {
    final storageRef = FirebaseStorage.instance.ref();
    final islandRef = storageRef.child(storageLocation);
    try {
      const maxSizeInBytes = 4096 * 4096;
      final Uint8List? imageData = (await islandRef.getData(maxSizeInBytes));
      return imageData ?? Uint8List(0);
    } on FirebaseException catch (e) {
      debugPrint("Hiba: $e");
    }
    return Uint8List(0);
  }
}

