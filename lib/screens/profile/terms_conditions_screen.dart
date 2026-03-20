import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
          'Terms & Conditions',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: January 1, 2024',
              style: AppTextStyles.caption.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: AppConstants.paddingL),

            _buildSection(
              title: '1. Acceptance of Terms',
              content:
                  'By accessing and using ${AppConstants.appName}, you accept and agree to be bound by the terms and provision of this agreement.',
            ),

            _buildSection(
              title: '2. Use License',
              content:
                  'Permission is granted to temporarily download one copy of the materials on ${AppConstants.appName} for personal, non-commercial transitory viewing only.',
            ),

            _buildSection(
              title: '3. Service Provider Agreement',
              content:
                  'All service providers listed on the platform are independent contractors. ${AppConstants.appName} acts as a platform to connect users with service providers and is not responsible for the quality of services provided.',
            ),

            _buildSection(
              title: '4. User Responsibilities',
              content:
                  'Users are responsible for:\n'
                  '• Providing accurate information\n'
                  '• Treating service providers with respect\n'
                  '• Making timely payments for services\n'
                  '• Following safety guidelines',
            ),

            _buildSection(
              title: '5. Payment Terms',
              content:
                  'All payments must be made through the app. ${AppConstants.appName} charges a commission on each booking. Refunds are subject to our refund policy.',
            ),

            _buildSection(
              title: '6. Cancellation Policy',
              content:
                  'Cancellations made 24 hours before the scheduled service will receive a full refund. Cancellations made within 24 hours may incur charges.',
            ),

            _buildSection(
              title: '7. Privacy',
              content:
                  'Your use of ${AppConstants.appName} is also governed by our Privacy Policy. Please review our Privacy Policy to understand our practices.',
            ),

            _buildSection(
              title: '8. Disclaimer',
              content:
                  'The materials on ${AppConstants.appName} are provided on an "as is" basis. ${AppConstants.appName} makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties.',
            ),

            _buildSection(
              title: '9. Limitations',
              content:
                  'In no event shall ${AppConstants.appName} or its suppliers be liable for any damages arising out of the use or inability to use the materials on ${AppConstants.appName}.',
            ),

            _buildSection(
              title: '10. Modifications',
              content:
                  '${AppConstants.appName} may revise these terms of service at any time without notice. By using this app, you are agreeing to be bound by the current version of these terms of service.',
            ),

            const SizedBox(height: AppConstants.paddingL),

            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                border: Border.all(
                  color: AppColors.info.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    child: Text(
                      'For any questions about these Terms, please contact us at ${AppConstants.supportEmail}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h6,
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
