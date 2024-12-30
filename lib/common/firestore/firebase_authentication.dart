
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:uton_flutter/common/api/auth_service.dart' as auth_service;
import 'package:uton_flutter/common/models/user.dart' as app_user;

class FirebaseAuthentication {

  FirebaseAuthentication._privateConstructor();
  final auth_service.AuthService _authService = auth_service.AuthService();

  static final FirebaseAuthentication shared = FirebaseAuthentication._privateConstructor();

  Future<void> registerUser(
      String name,
      String email,
      String password,
      String address,
      String birthdate,
      String gender) async {
    debugPrint("Registering user with email: $name, $email");
    try {
      firebase_auth.UserCredential userCredential = await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserData(name, email, address, gender, DateTime.parse(birthdate), userCredential.user);

    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      } else {
        debugPrint(e as String?);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential = await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _authService.saveToken(idToken);
        debugPrint('Token saved successfully!');
      } else {
        throw Exception('Failed to retrieve ID token.');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided.');
      } else {
        debugPrint(e.code);
      }
    }
  }

  Future<void> signOutUser() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
    await _authService.deleteToken();
    debugPrint("User signed out.");
  }

  Future<void> saveUserData(String name, String email, String address, String gender, DateTime birthDate, firebase_auth.User? firebaseUser) async {
    if (firebaseUser != null) {
      final appUser = app_user.User.fromFirebaseUser(firebaseUser as app_user.User, address: address, gender: gender, birthdate: birthDate);
      await FirebaseFirestore.instance.collection('users').doc(appUser.uid).set(appUser.toMap());

      await FirebaseFirestore.instance.collection('users').doc(appUser.uid).set({
        'name': name,
        'email': email,
        'address': address,
        'gender': gender,
        'birthDate': birthDate.toIso8601String(),
      });
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _authService.getToken();
    return token != null;
  }
}
