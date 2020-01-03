import 'package:Myinshora/models/Application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

// Create storage
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<Application> readApplication() async {
  var prefs = await _prefs;
  var app = prefs.getString("application");
  Map<String, dynamic> appData = convert.jsonDecode(app);
  return Application.fromJson(appData);
}

Future<void> saveApplication(app) async {
  Application application = app;
  print(application.toJson());
  var prefs = await _prefs;
  prefs.setString("application", "");
}

Future<void> removeUser() async {
  var prefs = await _prefs;
  prefs.remove("application");
}
