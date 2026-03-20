import 'package:flutter/material.dart';
import 'app_colors.dart';

class ServiceCategory {
  final String name;
  final IconData icon;
  final Color color;
  final String description;

  const ServiceCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });
}

class ServiceCategories {
  static const List<ServiceCategory> categories = [
    ServiceCategory(
      name: 'Security',
      icon: Icons.security,
      color: AppColors.categoryBlue,
      description: 'Bouncers & Security Guards',
    ),
    ServiceCategory(
      name: 'Housekeeping',
      icon: Icons.cleaning_services,
      color: AppColors.categoryGreen,
      description: 'Maids & Housekeepers',
    ),
    ServiceCategory(
      name: 'Carpentry',
      icon: Icons.carpenter,
      color: AppColors.categoryOrange,
      description: 'Carpenters & Furniture Work',
    ),
    ServiceCategory(
      name: 'Cooking',
      icon: Icons.restaurant,
      color: AppColors.categoryPurple,
      description: 'Cooks & Chefs',
    ),
    ServiceCategory(
      name: 'Plumbing',
      icon: Icons.plumbing,
      color: AppColors.categoryTeal,
      description: 'Plumbers & Pipe Work',
    ),
    ServiceCategory(
      name: 'Electrical',
      icon: Icons.electrical_services,
      color: AppColors.categoryRed,
      description: 'Electricians & Wiring',
    ),
    ServiceCategory(
      name: 'Painting',
      icon: Icons.format_paint,
      color: AppColors.categoryBlue,
      description: 'Painters & Decorators',
    ),
    ServiceCategory(
      name: 'Cleaning',
      icon: Icons.cleaning_services_outlined,
      color: AppColors.categoryGreen,
      description: 'Deep Cleaning Services',
    ),
    ServiceCategory(
      name: 'Gardening',
      icon: Icons.yard,
      color: AppColors.categoryOrange,
      description: 'Gardeners & Landscaping',
    ),
    ServiceCategory(
      name: 'Others',
      icon: Icons.more_horiz,
      color: AppColors.categoryPurple,
      description: 'Other Services',
    ),
  ];

  static ServiceCategory getCategoryByName(String name) {
    return categories.firstWhere(
      (category) => category.name.toLowerCase() == name.toLowerCase(),
      orElse: () => categories.last,
    );
  }
}
