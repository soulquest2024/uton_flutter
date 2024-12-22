


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uton_flutter/common/api/auth_service.dart';

class FirebaseAuthentication {

  FirebaseAuthentication._privateConstructor();
  final AuthService _authService = AuthService();

  static final FirebaseAuthentication shared = FirebaseAuthentication
      ._privateConstructor();

  Future<void> registerUser(
      String name,
      String email,
      String password,
      String address,
      String birthdate,
      String gender) async {
    debugPrint("Registering user with email: $name, $email");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserData(name, email, address, gender, DateTime.parse(birthdate));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _authService.saveToken(idToken);
        print('Token saved successfully!');
      } else {
        throw Exception('Failed to retrieve ID token.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
      else {
        print(e.code);
      }
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    await _authService.deleteToken();
    print("User signed out.");
  }

  Future<void> saveUserData(String name, String email, String address, String gender, DateTime birthDate) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
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
