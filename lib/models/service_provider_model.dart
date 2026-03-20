class ServiceProviderModel {
  final String id;
  final String name;
  final String profession;
  final String phoneNumber;
  final String? email;
  final String? profileImage;
  final double hourlyRate;
  final double dailyRate;
  final int experienceYears;
  final double rating;
  final int totalReviews;
  final String location;
  final String city;
  final String description;
  final List<String> skills;
  final bool isAvailable;
  final bool isVerified;

  ServiceProviderModel({
    required this.id,
    required this.name,
    required this.profession,
    required this.phoneNumber,
    this.email,
    this.profileImage,
    required this.hourlyRate,
    required this.dailyRate,
    required this.experienceYears,
    this.rating = 0.0,
    this.totalReviews = 0,
    required this.location,
    required this.city,
    required this.description,
    this.skills = const [],
    this.isAvailable = true,
    this.isVerified = false,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profession: json['profession'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'],
      profileImage: json['profileImage'],
      hourlyRate: (json['hourlyRate'] ?? 0).toDouble(),
      dailyRate: (json['dailyRate'] ?? 0).toDouble(),
      experienceYears: json['experienceYears'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      location: json['location'] ?? '',
      city: json['city'] ?? '',
      description: json['description'] ?? '',
      skills: json['skills'] != null
          ? List<String>.from(json['skills'])
          : [],
      isAvailable: json['isAvailable'] ?? true,
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profession': profession,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImage': profileImage,
      'hourlyRate': hourlyRate,
      'dailyRate': dailyRate,
      'experienceYears': experienceYears,
      'rating': rating,
      'totalReviews': totalReviews,
      'location': location,
      'city': city,
      'description': description,
      'skills': skills,
      'isAvailable': isAvailable,
      'isVerified': isVerified,
    };
  }
}
