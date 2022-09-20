import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:practic/screens/providerPage.dart';

class UserProvider {

  final String _dataPath = "assets/users.json";
  List<User> users = [];

  Future<String> loadAsset() async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    return users;
  }
}