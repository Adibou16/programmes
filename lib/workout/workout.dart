import 'package:shared_preferences/shared_preferences.dart';

class Workout {
  static late SharedPreferences _preferences;
  static const _keyWeight = 'weight';

  Workout();

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future saveWeight(weight) async {
    // Example: Save a dummy value
    await _preferences.setString(_keyWeight, weight);
  }

  static String? getWeight() => _preferences.getString(_keyWeight);
  
}