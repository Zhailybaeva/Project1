import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  Color primaryColor = const Color(0xFF8BE1DE); // Default color
  Color secondaryColor = const Color(0xFF398FA3); // Default color
  int userClass = 1; // Default userClass

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUserClass = prefs.getInt('userClass');
    if (savedUserClass != null) {
      userClass = savedUserClass;
      updateTheme(userClass);
      notifyListeners();
    }
  }

  void updateTheme(int newUserClass) async {
    userClass = newUserClass;
    if (userClass >= 1 && userClass <= 4) {
      primaryColor = const Color(0xFFBAE969); // Green color
      secondaryColor = const Color(0xFF5AB438); // Orange color
    } else if (userClass >= 5 && userClass <= 9) {
      primaryColor = const Color(0xFFBD6AE7); // Black color
      secondaryColor = const Color(0xFF6A3CB5); // Blue color
    } else if (userClass >= 10 && userClass <= 11) {
      primaryColor = const Color(0xFF60B0F5); // Red color
      secondaryColor = const Color(0xFF1572C3); // Purple color
    }

    // Сохраните userClass в SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userClass', userClass);

    notifyListeners();
  }
}
