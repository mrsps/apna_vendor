import 'dart:convert';
import 'package:av/models/appuser/appuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedCache {
  // User details in the cache or not
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEncoded = prefs.getString('user');
    if (userEncoded == null) return false;
    return true;
  }

  // Getting current user from cache
  Future<AppUser?> setUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEncode = await prefs.getString('user');
    if (userEncode != null) {
      AppUser appUser = AppUser.fromJson(jsonDecode(userEncode));
      return appUser;
    }
  }

  // Log user into cache
  Future<String?> logIn(AppUser appUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEncode = jsonEncode(appUser.toJson());
    await prefs.setString('user', userEncode);
    return userEncode;
  }

  // Log user out of cache
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
