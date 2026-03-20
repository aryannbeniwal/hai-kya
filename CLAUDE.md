# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

HAI KYA is a commission-based Flutter mobile application connecting users with service professionals (security guards, housekeepers, carpenters, cooks, etc.). The app targets Indian users with phone-based authentication (+91) and location-based service discovery.

**Current State**: Frontend-only implementation with demo data. Backend integration pending.

## Development Commands

```bash
# Install dependencies
flutter pub get

# Run app (debug mode)
flutter run

# Run with hot reload on specific device
flutter run -d <device-id>

# Analyze code for issues
flutter analyze

# Build debug APK
flutter build apk --debug --tree-shake-icons

# Build release APK
flutter build apk --release

# Clean build artifacts
flutter clean && flutter pub get
```

## Architecture Overview

### State Management Strategy
- **Provider Pattern**: All state managed via `ChangeNotifier` providers
- **AuthProvider** (`lib/providers/auth_provider.dart`): Handles login state, user data, and persistence via SharedPreferences
- **LocationProvider** (`lib/providers/location_provider.dart`): Manages location state, GPS permissions, and geocoding
- Providers wrapped at app root in `main.dart` via `MultiProvider`

### Design System Architecture
The app uses a centralized design system located in `lib/core/constants/`:

- **AppColors**: All colors referenced from single source. Never hardcode colors.
- **AppTextStyles**: Predefined text styles (h1-h6, body, button, etc.). Never create inline TextStyles.
- **AppConstants**: Spacing values, icon sizes, URLs, error messages. All magic numbers/strings should reference these.
- **ServiceCategories**: Service types with associated icons and colors.

**Rule**: When adding UI, always use constants from these files. If a needed constant doesn't exist, add it to the appropriate file first.

### Custom Widgets (`lib/core/widgets/`)
Reusable components that enforce design consistency:

- **CustomAppBar**: Location-aware app bar. Shows current location (left), profile icon (right). Auto-consumes `LocationProvider`.
- **CustomButton**: Supports 4 types (primary, secondary, outline, text) and 3 sizes (small, medium, large). Handles loading states.
- **CustomTextField**: Styled form inputs with consistent validation UI.

**When to create new custom widgets**: If a UI pattern repeats 3+ times, extract to `lib/core/widgets/`.

### Navigation Structure
```
SplashScreen (checks auth state)
    ↓
LoginScreen → OTPScreen → MainNavigationScreen (bottom nav)
                              ↓
                 ┌────────────┼────────────┐
                 ↓            ↓            ↓
            HomeScreen   BookingsScreen  ComboScreen
                 ↓
         LocationPickerScreen
                 ↓
           ProfileScreen → [sub-screens]
```

- **No routing package used**: Navigation via `Navigator.push/pop` and `MaterialPageRoute`
- **MainNavigationScreen** uses `IndexedStack` to preserve state across bottom nav tabs

### Data Flow Pattern
1. Screen consumes Provider via `Consumer<T>` or `Provider.of<T>(context)`
2. User action triggers provider method
3. Provider updates state and calls `notifyListeners()`
4. UI rebuilds automatically
5. State persisted to SharedPreferences when needed (auth, location)

### Current Data Strategy
All data is **hardcoded/demo** for now:
- Bookings: Static list in `bookings_screen.dart`
- Combos: Static list in `combo_screen.dart`
- Service categories: Defined in `service_categories.dart`

**When integrating backend**: Replace demo lists with API calls in providers. Create API service layer in `lib/services/`.

## Authentication Flow Details

**Login**: 10-digit Indian mobile number → generates OTP request
**OTP Screen**: 6-digit OTP input with **skip option** (for development, bypasses verification)
**Persistence**: Login state saved to SharedPreferences (`keyIsLoggedIn`, `keyUserPhone`)

**Important**: OTP verification is mocked. When integrating real OTP service, update `AuthProvider.verifyOTP()` method.

## Location Handling

Two location update paths:
1. **GPS-based**: Requires runtime permissions (already configured in AndroidManifest.xml)
   - Uses `geolocator` for position
   - Uses `geocoding` for reverse geocoding (coords → address)
2. **Manual entry**: User types location/city

Location updates propagate to:
- App bar display (via `LocationProvider`)
- User profile (via `AuthProvider.updateLocation()`)
- Persistent storage (SharedPreferences)

## Code Style Conventions

**Import organization**:
```dart
// Flutter/Dart packages first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Local imports grouped by type
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
```

**Naming**:
- Screens: `*_screen.dart` (e.g., `login_screen.dart`)
- Models: `*_model.dart`
- Providers: `*_provider.dart`
- Widgets: descriptive names (e.g., `custom_button.dart`)

**Constants usage**:
```dart
// ✅ Correct
padding: const EdgeInsets.all(AppConstants.paddingM)
style: AppTextStyles.h5
color: AppColors.primary

// ❌ Incorrect
padding: const EdgeInsets.all(16.0)
style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
color: Color(0xFF1E88E5)
```

## Known Issues / Technical Debt

1. **NDK Error on Build**: If you encounter NDK source.properties error, delete `/Users/mac/Library/Android/sdk/ndk/27.0.12077973` and let Gradle re-download.

2. **`withOpacity` Deprecation**: Multiple uses of `.withOpacity()` flagged by analyzer (Flutter 3.x deprecation). These are informational only but should eventually migrate to `.withValues()`.

3. **No Error Handling**: Network calls, location permissions, etc. lack comprehensive error handling. Should add try-catch and user-friendly error messages.

4. **Hardcoded Strings**: Some user-facing strings (e.g., in dialogs) not in AppConstants. Should centralize for i18n readiness.

## Integration Checklist (Backend)

When connecting to backend APIs:

1. Create `lib/services/` directory
2. Add `http` service layer (already in dependencies)
3. Update providers to call API instead of returning demo data:
   - `AuthProvider.login()` → POST to auth endpoint
   - `AuthProvider.verifyOTP()` → POST OTP verification
   - Create `BookingProvider` → fetch bookings from API
   - Create `ServiceProvider` → fetch service professionals
4. Add proper error handling and loading states
5. Replace demo data in:
   - `bookings_screen.dart` (bookings list)
   - `combo_screen.dart` (combos list)
   - Service categories (if backend-driven)
6. Implement actual commission calculation logic
7. Add payment gateway integration (not yet included)

## Key Files to Understand

- **`lib/main.dart`**: App entry, provider setup, splash screen logic
- **`lib/screens/main_navigation_screen.dart`**: Bottom navigation structure
- **`lib/providers/auth_provider.dart`**: Authentication state and persistence
- **`lib/core/constants/*.dart`**: Design system definitions

## Testing Notes

**Current Testing Approach**:
- Login: Any 10-digit number works
- OTP: Click "Skip for now" to bypass
- Location: Requires device location permissions (Android already configured)
- All bookings/combos are static demo data

No automated tests currently exist. When adding tests:
- Widget tests for custom widgets in `lib/core/widgets/`
- Provider tests for state management logic
- Integration tests for complete user flows
