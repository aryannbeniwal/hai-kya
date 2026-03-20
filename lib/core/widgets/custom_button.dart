import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

enum ButtonSize { small, medium, large }

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: _getButtonStyle(isDisabled),
        child: isLoading
            ? SizedBox(
                width: _getIconSize(),
                height: _getIconSize(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getTextColor(isDisabled),
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: _getIconSize(),
                      color: _getTextColor(isDisabled),
                    ),
                    const SizedBox(width: AppConstants.paddingS),
                  ],
                  Text(
                    text,
                    style: _getTextStyle().copyWith(
                      color: _getTextColor(isDisabled),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return AppConstants.buttonHeightSmall;
      case ButtonSize.medium:
        return AppConstants.buttonHeightMedium;
      case ButtonSize.large:
        return AppConstants.buttonHeightLarge;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return AppConstants.iconS;
      case ButtonSize.medium:
        return AppConstants.iconM;
      case ButtonSize.large:
        return AppConstants.iconL;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.buttonSmall;
      case ButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case ButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  ButtonStyle _getButtonStyle(bool isDisabled) {
    Color bgColor;
    Color borderColor = Colors.transparent;

    if (isDisabled) {
      bgColor = AppColors.buttonDisabled;
    } else {
      switch (type) {
        case ButtonType.primary:
          bgColor = backgroundColor ?? AppColors.buttonPrimary;
          break;
        case ButtonType.secondary:
          bgColor = backgroundColor ?? AppColors.buttonSecondary;
          break;
        case ButtonType.outline:
          bgColor = Colors.transparent;
          borderColor = backgroundColor ?? AppColors.primary;
          break;
        case ButtonType.text:
          bgColor = Colors.transparent;
          break;
      }
    }

    return ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: _getTextColor(isDisabled),
      elevation: type == ButtonType.outline || type == ButtonType.text ? 0 : 2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        side: type == ButtonType.outline
            ? BorderSide(color: borderColor, width: 1.5)
            : BorderSide.none,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size == ButtonSize.small
            ? AppConstants.paddingM
            : AppConstants.paddingL,
        vertical: AppConstants.paddingS,
      ),
    );
  }

  Color _getTextColor(bool isDisabled) {
    if (isDisabled) {
      return AppColors.textSecondary;
    }

    if (textColor != null) {
      return textColor!;
    }

    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return AppColors.textWhite;
      case ButtonType.outline:
        return backgroundColor ?? AppColors.primary;
      case ButtonType.text:
        return AppColors.primary;
    }
  }
}
