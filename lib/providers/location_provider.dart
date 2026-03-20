import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  String _currentLocation = 'Select Location';
  String _currentCity = 'India';
  bool _isLoading = false;
  Position? _currentPosition;

  String get currentLocation => _currentLocation;
  String get currentCity => _currentCity;
  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;

  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<bool> getCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        _currentLocation = place.subLocality ?? place.locality ?? 'Unknown';
        _currentCity = place.locality ?? place.administrativeArea ?? 'India';
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void updateLocation(String location, String city) {
    _currentLocation = location;
    _currentCity = city;
    notifyListeners();
  }

  void reset() {
    _currentLocation = 'Select Location';
    _currentCity = 'India';
    _currentPosition = null;
    notifyListeners();
  }
}
