import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../profile/profile_screen.dart';
import '../home/location_picker_screen.dart';

class ComboModel {
  final String id;
  final String title;
  final String description;
  final List<String> services;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final String validity;
  final bool isPopular;

  ComboModel({
    required this.id,
    required this.title,
    required this.description,
    required this.services,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.validity,
    this.isPopular = false,
  });

  double get savings => originalPrice - discountedPrice;
}

class ComboScreen extends StatefulWidget {
  const ComboScreen({super.key});

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends State<ComboScreen> {
  final List<ComboModel> _combos = [
    ComboModel(
      id: '1',
      title: 'Home Care Combo',
      description: 'Complete home care solution with housekeeping and cooking',
      services: ['Housekeeping', 'Cooking', 'Cleaning'],
      originalPrice: 5000,
      discountedPrice: 3500,
      discountPercentage: 30,
      validity: '30 Days',
      isPopular: true,
    ),
    ComboModel(
      id: '2',
      title: 'Security Plus',
      description: 'Enhanced security with day and night guards',
      services: ['Day Security', 'Night Security'],
      originalPrice: 8000,
      discountedPrice: 6400,
      discountPercentage: 20,
      validity: '30 Days',
    ),
    ComboModel(
      id: '3',
      title: 'Maintenance Package',
      description: 'All your maintenance needs covered',
      services: ['Plumbing', 'Electrical', 'Carpentry'],
      originalPrice: 4500,
      discountedPrice: 3150,
      discountPercentage: 30,
      validity: '15 Days',
      isPopular: true,
    ),
    ComboModel(
      id: '4',
      title: 'Weekend Special',
      description: 'Perfect for weekend deep cleaning and maintenance',
      services: ['Deep Cleaning', 'Gardening', 'Painting'],
      originalPrice: 6000,
      discountedPrice: 4200,
      discountPercentage: 30,
      validity: '2 Days',
    ),
  ];

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  void _navigateToLocationPicker() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPickerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(
        onLocationTap: _navigateToLocationPicker,
        onProfileTap: _navigateToProfile,
      ),
      body: _combos.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              itemCount: _combos.length,
              itemBuilder: (context, index) {
                return _buildComboCard(_combos[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.discount_outlined,
            size: 80,
            color: AppColors.iconSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            AppConstants.infoNoCombos,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComboCard(ComboModel combo) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: InkWell(
        onTap: () {
          _showComboDetails(combo);
        },
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with discount badge
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.7),
                        AppColors.primaryDark.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radiusL),
                      topRight: Radius.circular(AppConstants.radiusL),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (combo.isPopular) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.paddingS,
                              vertical: AppConstants.paddingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warning,
                              borderRadius: BorderRadius.circular(
                                AppConstants.radiusS,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.textPrimary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'POPULAR',
                                  style: AppTextStyles.captionBold.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppConstants.paddingS),
                        ],
                        Text(
                          combo.title,
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.textWhite,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingXS),
                        Text(
                          combo.description,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textWhite.withOpacity(0.9),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppConstants.paddingM,
                  right: AppConstants.paddingM,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingM,
                      vertical: AppConstants.paddingS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusCircular,
                      ),
                    ),
                    child: Text(
                      '${combo.discountPercentage}% OFF',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Services included
                  Text(
                    'Services Included:',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Wrap(
                    spacing: AppConstants.paddingS,
                    runSpacing: AppConstants.paddingS,
                    children: combo.services.map((service) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingM,
                          vertical: AppConstants.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusCircular,
                          ),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          service,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppConstants.paddingM),
                  const Divider(color: AppColors.divider),
                  const SizedBox(height: AppConstants.paddingM),

                  // Pricing and validity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '₹${combo.discountedPrice.toStringAsFixed(0)}',
                                style: AppTextStyles.priceMedium,
                              ),
                              const SizedBox(width: AppConstants.paddingS),
                              Text(
                                '₹${combo.originalPrice.toStringAsFixed(0)}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.paddingXS),
                          Text(
                            'Save ₹${combo.savings.toStringAsFixed(0)}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: AppConstants.iconS,
                            color: AppColors.iconSecondary,
                          ),
                          const SizedBox(height: AppConstants.paddingXS),
                          Text(
                            combo.validity,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.paddingM),

                  // Book Now Button
                  CustomButton(
                    text: 'Book Now',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking ${combo.title}'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    isFullWidth: true,
                    size: ButtonSize.medium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComboDetails(ComboModel combo) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.paddingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    combo.title,
                    style: AppTextStyles.h4,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingM),
              Text(
                combo.description,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppConstants.paddingL),
              Text(
                'Combo Details',
                style: AppTextStyles.h6,
              ),
              const SizedBox(height: AppConstants.paddingM),
              Text(
                'This combo includes ${combo.services.length} services: ${combo.services.join(", ")}',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppConstants.paddingL),
              CustomButton(
                text: 'Book for ₹${combo.discountedPrice.toStringAsFixed(0)}',
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking ${combo.title}'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                isFullWidth: true,
                size: ButtonSize.large,
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }
}
