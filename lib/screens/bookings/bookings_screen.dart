import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../models/booking_model.dart';
import '../profile/profile_screen.dart';
import '../home/location_picker_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<BookingModel> _demoBookings = [
    BookingModel(
      id: '1',
      userId: 'user1',
      serviceProviderId: 'sp1',
      serviceProviderName: 'Rajesh Kumar',
      profession: 'Security Guard',
      bookingType: 'single',
      bookingDate: DateTime.now().add(const Duration(days: 2)),
      totalAmount: 1500,
      status: 'confirmed',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    BookingModel(
      id: '2',
      userId: 'user1',
      serviceProviderId: 'sp2',
      serviceProviderName: 'Sunita Devi',
      profession: 'Housekeeping',
      bookingType: 'multiple',
      bookingDate: DateTime.now().add(const Duration(days: 5)),
      totalAmount: 2500,
      status: 'pending',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    BookingModel(
      id: '3',
      userId: 'user1',
      serviceProviderId: 'sp3',
      serviceProviderName: 'Ramesh Carpenter',
      profession: 'Carpentry',
      bookingType: 'single',
      bookingDate: DateTime.now().subtract(const Duration(days: 2)),
      totalAmount: 3000,
      status: 'completed',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  List<BookingModel> _getBookingsByStatus(String status) {
    if (status == 'all') {
      return _demoBookings;
    }
    return _demoBookings.where((b) => b.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(
        onLocationTap: _navigateToLocationPicker,
        onProfileTap: _navigateToProfile,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.cardBackground,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: AppTextStyles.tabText.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTextStyles.tabText,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Pending'),
                Tab(text: 'Confirmed'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingList('all'),
                _buildBookingList('pending'),
                _buildBookingList('confirmed'),
                _buildBookingList('completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList(String status) {
    final bookings = _getBookingsByStatus(status);

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 80,
              color: AppColors.iconSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              AppConstants.infoNoBookings,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(bookings[index]);
      },
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing booking #${booking.id}'),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          child: Text(
                            booking.serviceProviderName[0].toUpperCase(),
                            style: AppTextStyles.h5.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.paddingM),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.serviceProviderName,
                                style: AppTextStyles.h6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppConstants.paddingXS),
                              Text(
                                booking.profession,
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(booking.status),
                ],
              ),
              const SizedBox(height: AppConstants.paddingM),
              const Divider(color: AppColors.divider),
              const SizedBox(height: AppConstants.paddingM),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      Icons.calendar_today,
                      _formatDate(booking.bookingDate),
                    ),
                  ),
                  Expanded(
                    child: _buildInfoRow(
                      Icons.currency_rupee,
                      booking.totalAmount.toStringAsFixed(0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingS),
              _buildInfoRow(
                booking.bookingType == 'single'
                    ? Icons.person
                    : Icons.groups,
                booking.bookingType == 'single'
                    ? 'Single Booking'
                    : 'Multiple Booking',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = AppColors.pending.withOpacity(0.2);
        textColor = AppColors.pending;
        break;
      case 'confirmed':
        backgroundColor = AppColors.info.withOpacity(0.2);
        textColor = AppColors.info;
        break;
      case 'completed':
        backgroundColor = AppColors.success.withOpacity(0.2);
        textColor = AppColors.success;
        break;
      case 'cancelled':
        backgroundColor = AppColors.error.withOpacity(0.2);
        textColor = AppColors.error;
        break;
      default:
        backgroundColor = AppColors.inactive.withOpacity(0.2);
        textColor = AppColors.inactive;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
        vertical: AppConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTextStyles.captionBold.copyWith(
          color: textColor,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppConstants.iconS,
          color: AppColors.iconSecondary,
        ),
        const SizedBox(width: AppConstants.paddingS),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 0) {
      return 'In $difference days';
    } else {
      return '${difference.abs()} days ago';
    }
  }
}
