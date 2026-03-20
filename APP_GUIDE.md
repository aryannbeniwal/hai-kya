# HAI KYA - Service Provider App

## Overview
HAI KYA is a commission-based service provider platform similar to LinkedIn, but focused on connecting users with various service professionals like security guards, housekeepers, carpenters, cooks, and more.

## App Structure

```
lib/
├── main.dart                          # App entry point with splash screen
├── core/
│   ├── constants/
│   │   ├── app_colors.dart           # Centralized color definitions
│   │   ├── app_text_styles.dart      # Consistent text styles
│   │   ├── app_constants.dart        # App-wide constants
│   │   └── service_categories.dart   # Service categories data
│   └── widgets/
│       ├── custom_app_bar.dart       # Reusable app bar with location
│       ├── custom_button.dart        # Styled button component
│       └── custom_text_field.dart    # Styled input field
├── models/
│   ├── user_model.dart              # User data model
│   ├── service_provider_model.dart  # Service provider data
│   └── booking_model.dart           # Booking data model
├── providers/
│   ├── auth_provider.dart           # Authentication state management
│   └── location_provider.dart       # Location state management
└── screens/
    ├── auth/
    │   ├── login_screen.dart        # Phone number login
    │   └── otp_screen.dart          # OTP verification (with skip)
    ├── home/
    │   ├── home_screen.dart         # Main home with services
    │   └── location_picker_screen.dart # Location selection
    ├── bookings/
    │   └── bookings_screen.dart     # View all bookings
    ├── combo/
    │   └── combo_screen.dart        # Combo offers/coupons
    ├── profile/
    │   ├── profile_screen.dart      # User profile menu
    │   ├── my_account_screen.dart   # Account management
    │   ├── refer_earn_screen.dart   # Referral program
    │   ├── terms_conditions_screen.dart
    │   └── help_support_screen.dart
    └── main_navigation_screen.dart  # Bottom navigation
```

## Features Implemented

### 1. Authentication Flow
- **Login Screen**: Indian mobile number input (+91)
- **OTP Screen**: 6-digit OTP verification with skip option
- Persistent login state using SharedPreferences

### 2. Home Screen
- **Custom App Bar**:
  - Current location display (left)
  - Profile icon (right)
  - Tap location to update
- **Search Bar**: Find services
- **Quick Booking Options**:
  - Single Booking
  - Multiple Booking
- **Service Categories Grid**: 10 service types with icons

### 3. Bookings Screen
- **Tabbed View**: All, Pending, Confirmed, Completed
- Demo bookings with status indicators
- Booking cards showing:
  - Service provider info
  - Profession
  - Date and amount
  - Booking type

### 4. Combo/Coupons Screen
- Special combo offers with discounts
- Services included in each combo
- Pricing with savings calculation
- Validity period display
- Popular badges for trending combos

### 5. Profile Screen
- **My Account**: Edit profile details
- **Refer & Earn**: Referral code sharing
- **Terms & Conditions**: Legal information
- **Help & Support**: FAQs and contact options
- **Rate Us**: App rating dialog
- **Sign Out**: Logout functionality

### 6. Location Features
- GPS-based current location detection
- Manual location entry
- Location update across app
- Geocoding integration

## Design System

### Colors (app_colors.dart)
- **Primary**: Blue (#1E88E5)
- **Secondary**: Teal (#26A69A)
- **Status Colors**: Success, Warning, Error, Info
- **Category Colors**: 6 vibrant colors for services
- Consistent color palette throughout

### Typography (app_text_styles.dart)
- **Headings**: H1-H6 styles
- **Body Text**: Large, Medium, Small
- **Buttons**: 3 sizes
- **Specialized**: Price, Caption, Label styles

### Spacing & Layout (app_constants.dart)
- Consistent padding: XS(4), S(8), M(16), L(24), XL(32)
- Border radius: S(4), M(8), L(12), XL(16)
- Icon sizes: XS(16), S(20), M(24), L(32), XL(48)

## Navigation Flow

```
Splash Screen
    ↓
Login Screen → OTP Screen → Main Navigation
                                  ↓
                    ┌─────────────┼─────────────┐
                    ↓             ↓             ↓
                Home Tab    Bookings Tab   Combos Tab
                    ↓
            ┌───────┼───────┐
            ↓               ↓
    Location Picker    Profile Menu
                            ↓
                    ┌───────┼────────┐
                    ↓       ↓        ↓
                Account  Refer   Help...
```

## Key Dependencies

```yaml
provider: ^6.1.1          # State management
geolocator: ^11.0.0       # Location services
geocoding: ^3.0.0         # Address from coordinates
shared_preferences: ^2.2.2 # Local storage
flutter_rating_bar: ^4.0.1 # Rating UI
url_launcher: ^6.2.5      # External links
```

## Running the App

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run on device/emulator**:
   ```bash
   flutter run
   ```

3. **Build for release**:
   ```bash
   flutter build apk --release     # Android
   flutter build ios --release     # iOS
   ```

## Testing the App

### Login Flow
1. Enter any 10-digit mobile number
2. Click "Get OTP"
3. Either enter 6-digit OTP or click "Skip for now"
4. You'll be taken to the main app

### Location
1. Tap location in app bar
2. Choose "Use Current Location" (requires GPS permission)
3. Or manually enter location and city
4. Location updates throughout the app

### Profile
1. Tap profile icon in app bar
2. Explore all profile options
3. Try editing account details
4. Check referral code section

## Future Enhancements

### Backend Integration
- Replace demo data with API calls
- Real OTP verification service
- User registration as seeker
- Service provider profiles from API

### Additional Features
- Service provider search and filtering
- Detailed service provider profiles
- Booking creation flow
- Payment gateway integration
- Real-time booking status
- Chat with service providers
- Reviews and ratings
- Push notifications

### UI Improvements
- Add assets and images
- Custom fonts
- Animations and transitions
- Skeleton loaders
- Pull-to-refresh

## Code Quality

- **Consistent Styling**: All UI follows design system
- **Reusable Components**: Custom widgets for common patterns
- **State Management**: Provider pattern for reactive UI
- **Type Safety**: Strong typing with models
- **Clean Architecture**: Separation of concerns

## Permissions Required

### Android (AndroidManifest.xml)
- `INTERNET`: API calls
- `ACCESS_FINE_LOCATION`: GPS location
- `ACCESS_COARSE_LOCATION`: Network location

### iOS (Info.plist) - Add these if building for iOS:
- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysUsageDescription`

## Contact & Support

For any questions or issues:
- Email: support@haikya.com
- Phone: +91 1234567890

---

**Version**: 1.0.0
**Last Updated**: March 20, 2026
**Built with**: Flutter 3.x
