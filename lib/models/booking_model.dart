class BookingModel {
  final String id;
  final String userId;
  final String serviceProviderId;
  final String serviceProviderName;
  final String profession;
  final String bookingType;
  final DateTime bookingDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final double totalAmount;
  final String status;
  final String? notes;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceProviderId,
    required this.serviceProviderName,
    required this.profession,
    required this.bookingType,
    required this.bookingDate,
    this.startTime,
    this.endTime,
    required this.totalAmount,
    this.status = 'pending',
    this.notes,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      serviceProviderId: json['serviceProviderId'] ?? '',
      serviceProviderName: json['serviceProviderName'] ?? '',
      profession: json['profession'] ?? '',
      bookingType: json['bookingType'] ?? 'single',
      bookingDate: json['bookingDate'] != null
          ? DateTime.parse(json['bookingDate'])
          : DateTime.now(),
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : null,
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'])
          : null,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      notes: json['notes'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceProviderId': serviceProviderId,
      'serviceProviderName': serviceProviderName,
      'profession': profession,
      'bookingType': bookingType,
      'bookingDate': bookingDate.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'totalAmount': totalAmount,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get statusDisplay {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
