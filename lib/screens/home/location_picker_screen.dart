import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../providers/location_provider.dart';
import '../../providers/auth_provider.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  bool _isLoadingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _locationController.text = locationProvider.currentLocation;
    _cityController.text = locationProvider.currentCity;
  }

  @override
  void dispose() {
    _locationController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingCurrentLocation = true;
    });

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final success = await locationProvider.getCurrentLocation();

    setState(() {
      _isLoadingCurrentLocation = false;
    });

    if (success) {
      _locationController.text = locationProvider.currentLocation;
      _cityController.text = locationProvider.currentCity;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.successLocationUpdate),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.errorLocation),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _saveLocation() {
    final location = _locationController.text.trim();
    final city = _cityController.text.trim();

    if (location.isEmpty || city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both location and city'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.updateLocation(location, city);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateLocation(location, city);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppConstants.successLocationUpdate),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 2,
        shadowColor: AppColors.shadow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Location',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Use Current Location Card
            Card(
              color: AppColors.cardBackground,
              elevation: 2,
              shadowColor: AppColors.shadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
              ),
              child: InkWell(
                onTap: _isLoadingCurrentLocation ? null : _getCurrentLocation,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingL),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppConstants.paddingM),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusM),
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: AppColors.primary,
                          size: AppConstants.iconL,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Use Current Location',
                              style: AppTextStyles.h6,
                            ),
                            const SizedBox(height: AppConstants.paddingXS),
                            Text(
                              'Auto-detect using GPS',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      if (_isLoadingCurrentLocation)
                        const SizedBox(
                          width: AppConstants.iconM,
                          height: AppConstants.iconM,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      else
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.iconSecondary,
                          size: AppConstants.iconS,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppConstants.paddingL),

            // Divider with OR text
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.divider)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingM,
                  ),
                  child: Text(
                    'OR',
                    style: AppTextStyles.caption,
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.divider)),
              ],
            ),

            const SizedBox(height: AppConstants.paddingL),

            // Manual Location Entry
            Text(
              'Enter Location Manually',
              style: AppTextStyles.h6,
            ),

            const SizedBox(height: AppConstants.paddingM),

            CustomTextField(
              controller: _locationController,
              labelText: 'Area / Locality',
              hintText: 'Enter your area or locality',
              prefixIcon: const Icon(
                Icons.location_on_outlined,
                color: AppColors.iconSecondary,
              ),
            ),

            const SizedBox(height: AppConstants.paddingM),

            CustomTextField(
              controller: _cityController,
              labelText: 'City',
              hintText: 'Enter your city',
              prefixIcon: const Icon(
                Icons.location_city,
                color: AppColors.iconSecondary,
              ),
            ),

            const SizedBox(height: AppConstants.paddingXL),

            // Save Button
            CustomButton(
              text: 'Save Location',
              onPressed: _saveLocation,
              isFullWidth: true,
              size: ButtonSize.large,
              icon: Icons.check,
            ),
          ],
        ),
      ),
    );
  }
}
