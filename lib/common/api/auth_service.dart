
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String idToken) async {
    await _storage.write(key: 'idToken', value: idToken);
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: 'idToken');

    if (token == null || await isTokenExpired(token)) {
      return await refreshAndSaveToken();
    }
    return token;
  }

  Future<bool> isTokenExpired(String idToken) async {
    final parts = idToken.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token format');
    }

    final payload = parts[1];
    final decoded = String.fromCharCodes(base64Url.decode(base64Url.normalize(payload)));
    final expiration = json.decode(decoded)['exp'];

    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return currentTime > expiration;
  }

  Future<String> refreshAndSaveToken() async {
    final newToken = await refreshIdToken();
    await _storage.write(key: 'idToken', value: newToken);
    return newToken ?? "";
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'idToken');
  }

  Future<String?> refreshIdToken() async {
    try {
      String? idToken = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      debugPrint('Token refreshed: $idToken');
      return idToken;
    } catch (e) {
      debugPrint('Failed to refresh token: $e');
      rethrow;
    }
  }
}

