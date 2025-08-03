import 'package:flutter/material.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

//~ Enum to manage which tab is currently selected
enum BookingTab { enrolments, bookings }

class _BookingsPageState extends State<BookingsPage> {
  BookingTab _selectedTab = BookingTab.enrolments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('My Bookings & Enrolments',
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 18.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      _buildTab('Enrolments', BookingTab.enrolments),
                      _buildTab('Bookings', BookingTab.bookings),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _selectedTab == BookingTab.enrolments
                  ? const _EnrolmentsList()
                  : const _BookingsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, BookingTab tab) {
    final isSelected = _selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = tab;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//! --- Enrolments Section ---

class _EnrolmentsList extends StatefulWidget {
  const _EnrolmentsList();

  @override
  State<_EnrolmentsList> createState() => _EnrolmentsListState();
}

class _EnrolmentsListState extends State<_EnrolmentsList> {
  String _selectedFilter = 'Upcoming';
  final List<String> _filterOptions = [
    'All',
    'Upcoming',
    'Ongoing',
    'Completed',
    'Cancelled'
  ];

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _FilterBottomSheet(
          title: 'Filter Enrolments',
          options: _filterOptions,
          selectedOption: _selectedFilter,
          onFilterSelected: (newFilter) {
            setState(() {
              _selectedFilter = newFilter;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        _buildSectionHeader('Classes', _selectedFilter, _showFilterBottomSheet),
        _EnrolmentCard(
          status: 'Voucher',
          statusColor: const Color.fromARGB(255, 121, 15, 228),
          date: '10 July 2025',
          isVoucher: true,
        ),
        _EnrolmentCard(
          status: 'Upcoming',
          statusColor: const Color.fromARGB(255, 186, 163, 104),
          date: 'May 12, 2025, from 5:00 PM to 6:30 PM',
          showProgress: true,
        ),
        _EnrolmentCard(
          status: 'Upcoming',
          statusColor: const Color.fromARGB(255, 186, 163, 104),
          date: 'May 12, 2025, from 5:00 PM to 6:30 PM',
          showProgress: true,
        ),
        _EnrolmentCard(
          status: 'Upcoming',
          statusColor: const Color.fromARGB(255, 186, 163, 104),
          date: 'May 12, 2025, from 5:00 PM to 6:30 PM',
          showProgress: true,
        ),
      ],
    );
  }
}

class _EnrolmentCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String date;
  final bool showProgress;
  final bool isVoucher;

  const _EnrolmentCard({
    required this.status,
    required this.statusColor,
    required this.date,
    this.showProgress = false,
    this.isVoucher = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/kathak_class.jpg',
                    width: 120, height: 120, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            isVoucher
                                ? 'Voucher ID: #CL8901'
                                : 'Enrollment ID: #CL8901',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(status,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Kathak Sessions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const Text('By Taal performing arts',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Text(isVoucher ? 'Expiry' : 'Upcoming Class',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: date == '10 July 2025'
                            ? const Color.fromARGB(255, 231, 104, 146)
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showProgress) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    value: 10 / 15,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Classes Completed',
                    style: TextStyle(color: Colors.white)),
                const Spacer(),
                Text('10 out of 15',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 244, 3),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code, color: Color.fromARGB(255, 162, 96, 238)),
                SizedBox(width: 8),
                Text('Show QR to Mark attendance',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 162, 96, 238))),
              ],
            )
          ]
        ],
      ),
    );
  }
}

//! --- Bookings Section ---

class _BookingsList extends StatefulWidget {
  const _BookingsList();

  @override
  State<_BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<_BookingsList> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Upcoming', 'Past', 'Cancelled'];

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _FilterBottomSheet(
          title: 'Filter Bookings',
          options: _filterOptions,
          selectedOption: _selectedFilter,
          onFilterSelected: (newFilter) {
            setState(() {
              _selectedFilter = newFilter;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        _buildSectionHeader(
            'Experiences', _selectedFilter, _showFilterBottomSheet),
        _BookingCard(
          status: 'Upcoming',
          statusColor: const Color.fromARGB(255, 236, 199, 107),
          imagePath: 'assets/camel_ride.jpg',
          reservationDate: 'May 5, 2025 at 2:30 PM',
          venue: 'Culinary Avenue, Suite 48',
        ),
        _BookingCard(
          status: 'Past',
          statusColor: Colors.grey,
          imagePath: 'assets/art_class_booking.png',
          reservationDate: 'May 12, 2025 at 5:00 PM',
          venue: 'Oceanview Hall, Level 3',
        ),
        _BookingCard(
          status: 'Cancelled',
          statusColor: const Color.fromARGB(255, 232, 103, 94),
          imagePath: 'assets/art_class_booking_cancle.jpg',
          reservationDate: 'June 13, 2025 at 7:00 PM',
          venue: 'Grand Ballroom, Main Lodge',
        ),
      ],
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String imagePath;
  final String reservationDate;
  final String venue;

  const _BookingCard({
    required this.status,
    required this.statusColor,
    required this.imagePath,
    required this.reservationDate,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(imagePath,
                    width: 120, height: 120, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Booking ID: #BK8901',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(status,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Emerald Bay Sunset Haven',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoColumn('Reservation Date & Time', reservationDate),
              SizedBox(
                height: 30,
                child: const VerticalDivider(color: Color(0xFF2C2C2E)),
              ),
              _buildInfoColumn('Venue Location', venue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

//! --- Common Helper Widgets ---

class _FilterBottomSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String) onFilterSelected;

  const _FilterBottomSheet({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // The handle at the top
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // The "Status" title
          const Text(
            'Status',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // The list of filter options
          Column(
            children: options.map((option) {
              final isSelected = option == selectedOption;
              return ListTile(
                onTap: () => onFilterSelected(option),
                leading: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.yellow : Colors.grey,
                ),
                title: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Widget _buildSectionHeader(
    String title, String filterValue, VoidCallback onFilterTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(filterValue, style: const TextStyle(color: Colors.white)),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
