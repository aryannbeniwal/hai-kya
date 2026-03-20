class AppConstants {
  // App Info
  static const String appName = 'HAI KYA';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Find the perfect service provider';

  // Padding & Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusCircular = 100.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Button Sizes
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Navigation
  static const int defaultTabIndex = 0;

  // Form Validation
  static const int phoneNumberLength = 10;
  static const int otpLength = 6;

  // Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserPhone = 'user_phone';
  static const String keyUserLocation = 'user_location';
  static const String keyUserCity = 'user_city';

  // Default Values
  static const String defaultLocation = 'Select Location';
  static const String defaultCity = 'India';

  // URLs & Links
  static const String privacyPolicyUrl = 'https://example.com/privacy-policy';
  static const String termsConditionsUrl = 'https://example.com/terms-conditions';
  static const String helpSupportUrl = 'https://example.com/help-support';
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.haikya.app';
  static const String appStoreUrl = 'https://apps.apple.com/app/haikya/id123456789';

  // Contact Info
  static const String supportEmail = 'support@haikya.com';
  static const String supportPhone = '+91 1234567890';

  // Booking Types
  static const String bookingTypeSingle = 'single';
  static const String bookingTypeMultiple = 'multiple';

  // Service Categories
  static const List<String> serviceCategories = [
    'Security',
    'Housekeeping',
    'Carpentry',
    'Cooking',
    'Plumbing',
    'Electrical',
    'Painting',
    'Cleaning',
    'Gardening',
    'Others',
  ];

  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No internet connection. Please check your network.';
  static const String errorInvalidPhone = 'Please enter a valid 10-digit phone number.';
  static const String errorInvalidOTP = 'Please enter a valid OTP.';
  static const String errorLocation = 'Unable to fetch location. Please try again.';

  // Success Messages
  static const String successLogin = 'Login successful!';
  static const String successOTP = 'OTP verified successfully!';
  static const String successBooking = 'Booking created successfully!';
  static const String successLocationUpdate = 'Location updated successfully!';

  // Info Messages
  static const String infoNoBookings = 'No bookings found.';
  static const String infoNoCombos = 'No combo offers available.';
  static const String infoSearchServices = 'Search for services you need';
}
