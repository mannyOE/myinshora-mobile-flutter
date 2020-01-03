import 'package:Myinshora/models/Application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

// Create storage
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<User> readUser() async {
  var prefs = await _prefs;
  try {
    var user = prefs.getString("user");
    Map<String, dynamic> userData = convert.jsonDecode(user);
    return User.fromJson(userData);
  } catch (e) {
    return null;
  }
}

Future<String> readUserAsString() async {
  var prefs = await _prefs;
  var user = prefs.getString("user");
  return user;
}

Future<void> saveUser(user) async {
  var prefs = await _prefs;
  prefs.setString("user", convert.jsonEncode(user));
  readToken();
}

Future<void> removeUser() async {
  var prefs = await _prefs;
  prefs.remove("user");
}

Future<String> readToken() async {
  var prefs = await _prefs;
  var token = prefs.get("token");
  return token;
}

Future<void> saveToken(token) async {
  var prefs = await _prefs;
  prefs.setString("token", token);
}

Future<void> removeToken() async {
  var prefs = await _prefs;
  prefs.remove("token");
}
