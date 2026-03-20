import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;

    if (_isLoggedIn) {
      final phoneNumber = prefs.getString(AppConstants.keyUserPhone);
      final location = prefs.getString(AppConstants.keyUserLocation);
      final city = prefs.getString(AppConstants.keyUserCity);

      if (phoneNumber != null) {
        _user = UserModel(
          phoneNumber: phoneNumber,
          location: location,
          city: city,
        );
      }
    }
    notifyListeners();
  }

  Future<bool> login(String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyIsLoggedIn, true);
      await prefs.setString(AppConstants.keyUserPhone, phoneNumber);

      _user = UserModel(phoneNumber: phoneNumber);
      _isLoggedIn = true;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateLocation(String location, String city) async {
    if (_user != null) {
      _user = _user!.copyWith(location: location, city: city);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserLocation, location);
      await prefs.setString(AppConstants.keyUserCity, city);

      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _user = null;
    _isLoggedIn = false;
    _isLoading = false;

    notifyListeners();
  }
}
