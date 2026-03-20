class UserModel {
  final String? id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final String? location;
  final String? city;
  final DateTime? createdAt;

  UserModel({
    this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    this.location,
    this.city,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phoneNumber: json['phoneNumber'] ?? '',
      name: json['name'],
      email: json['email'],
      location: json['location'],
      city: json['city'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'location': location,
      'city': city,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
    String? location,
    String? city,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
