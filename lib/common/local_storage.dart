
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageKeys {
  static const String selectedLanguageCodeKey = "selectedLanguageCodeKey";
  static const String accessTokenKey = "accessTokenKey";

}

class LocalStorage {
  LocalStorage._privateConstructor();
  static final LocalStorage shared = LocalStorage._privateConstructor();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  //-----READ-----
  Future<String?> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(key);
    } catch (e, trace) {
      debugPrint(trace.toString());
      return null;
    }
  }

  Future<int?> readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getInt(key);
    } catch (e, trace) {
      debugPrint(trace.toString());
      return null;
    }
  }

  Future<double?> readDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getDouble(key);
    } catch (e, trace) {
      debugPrint(trace.toString());
      return null;
    }
  }

  Future<bool?> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getBool(key);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<DateTime?> readDate(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? read = prefs.getString(key);
      return (read == null || read.isEmpty) ? null : DateTime.parse(read);
    } catch (e, trace) {
      debugPrint("readDate: failed to parse date time: $e");
      return null;
    }
  }

  //-----SAVE-----
  Future<bool> saveInt(String key, int? value) async {
    final prefs = await SharedPreferences.getInstance();
    if(value != null) {
      return await prefs.setInt(key, value);
    } else {
      return await prefs.remove(key);
    }
  }

  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  Future<bool> saveBool(String key, {required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  Future<bool> saveDouble(String key, double? value) async {
    final prefs = await SharedPreferences.getInstance();
    if(value != null) {
      return await prefs.setDouble(key, value);
    } else {
      return await prefs.remove(key);
    }
  }

  Future<bool> saveDate(String key, DateTime? value) async {
    final prefs = await SharedPreferences.getInstance();
    if(value != null) {
      return await prefs.setString(key, value.toString());
    } else {
      return await prefs.remove(key);
    }
  }

  //-----Clear-----
  Future<bool> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  Future<bool> clearKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}

