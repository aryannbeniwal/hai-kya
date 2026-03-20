import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  static const String _referralCode = 'HAIKYA2024';

  void _copyReferralCode(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: _referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral code copied to clipboard!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _shareReferral(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening share options...'),
        backgroundColor: AppColors.info,
      ),
    );
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
          'Refer & Earn',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Illustration Card
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingXL),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primaryDark,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.card_giftcard,
                    size: 80,
                    color: AppColors.iconWhite,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Text(
                    'Refer Friends & Earn',
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.textWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'Get ₹500 for each successful referral',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textWhite.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.paddingXL),

            // How it works
            Text(
              'How it works',
              style: AppTextStyles.h5,
            ),

            const SizedBox(height: AppConstants.paddingM),

            _buildStep(
              number: 1,
              title: 'Share your code',
              description: 'Share your unique referral code with friends',
              icon: Icons.share,
            ),

            _buildStep(
              number: 2,
              title: 'Friend signs up',
              description: 'Your friend creates an account using your code',
              icon: Icons.person_add,
            ),

            _buildStep(
              number: 3,
              title: 'Both get rewarded',
              description: 'You and your friend both get ₹500 credit',
              icon: Icons.celebration,
            ),

            const SizedBox(height: AppConstants.paddingXL),

            // Referral Code Card
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingL),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Referral Code',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingL,
                      vertical: AppConstants.paddingM,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      border: Border.all(
                        color: AppColors.primary,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _referralCode,
                      style: AppTextStyles.h3.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Copy Code',
                          onPressed: () => _copyReferralCode(context),
                          icon: Icons.copy,
                          size: ButtonSize.medium,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingM),
                      Expanded(
                        child: CustomButton(
                          text: 'Share',
                          onPressed: () => _shareReferral(context),
                          type: ButtonType.secondary,
                          icon: Icons.share,
                          size: ButtonSize.medium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.paddingXL),

            // Stats Card
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingL),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Referrals',
                    style: AppTextStyles.h6,
                  ),
                  const SizedBox(height: AppConstants.paddingL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat('Total', '5'),
                      Container(
                        height: 40,
                        width: 1,
                        color: AppColors.divider,
                      ),
                      _buildStat('Successful', '3'),
                      Container(
                        height: 40,
                        width: 1,
                        color: AppColors.divider,
                      ),
                      _buildStat('Earned', '₹1500'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.paddingM),

            // Terms
            Text(
              'Terms and conditions apply. Referral rewards are subject to verification.',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required int number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: AppTextStyles.h6.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: AppConstants.iconS,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppConstants.paddingS),
                    Text(
                      title,
                      style: AppTextStyles.label.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h4.copyWith(
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppConstants.paddingXS),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
