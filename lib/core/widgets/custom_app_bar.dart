import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';
import '../../providers/location_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLocation;
  final bool showProfile;
  final VoidCallback? onLocationTap;
  final VoidCallback? onProfileTap;
  final String? title;

  const CustomAppBar({
    super.key,
    this.showLocation = true,
    this.showProfile = true,
    this.onLocationTap,
    this.onProfileTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 2,
      shadowColor: AppColors.shadow,
      title: showLocation
          ? _buildLocationWidget(context)
          : title != null
              ? Text(
                  title!,
                  style: AppTextStyles.appBarTitle,
                )
              : null,
      actions: showProfile
          ? [
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: AppColors.iconPrimary,
                  size: AppConstants.iconL,
                ),
                onPressed: onProfileTap,
              ),
              const SizedBox(width: AppConstants.paddingS),
            ]
          : null,
    );
  }

  Widget _buildLocationWidget(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return InkWell(
          onTap: onLocationTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingS,
              vertical: AppConstants.paddingXS,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: AppConstants.iconM,
                ),
                const SizedBox(width: AppConstants.paddingXS),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        locationProvider.currentLocation,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        locationProvider.currentCity,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppConstants.paddingXS),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.iconSecondary,
                  size: AppConstants.iconS,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
