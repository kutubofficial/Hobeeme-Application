import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class UserLoader {
  static Future<List<UserModel>> loadUsers() async {
    final String jsonString = await rootBundle.loadString('assets/users.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }
}
