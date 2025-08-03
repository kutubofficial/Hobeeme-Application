import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 60),
            _buildScoreCard(),
            const SizedBox(height: 16),
            _buildInfoGrid(),
            const SizedBox(height: 24),
            _buildAccountMenuList(),
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileHeader() {
  return SizedBox(
    height: 235,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 195,
          decoration: const BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 65,
                left: 20,
                child: Image.asset('assets/rocket.gif', height: 90),
              ),
              Positioned(
                top: 140,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.edit_outlined, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 145,
          left: 25,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_pic.jpg'),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.black, size: 16),
              ),
            ],
          ),
        ),
        Positioned(
          top: 200,
          left: 140,
          right: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kom Hillson',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  Text('Tomhill@mail.com',
                      style: TextStyle(color: Colors.grey[400])),
                ],
              ),
              Row(
                children: [
                  _buildDetailColumn('24', 'Age'),
                  const SizedBox(width: 16),
                  _buildDetailColumn('Female', 'Gender'),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDetailColumn(String value, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
      Text(label, style: TextStyle(color: Colors.grey[400])),
    ],
  );
}

Widget _buildScoreCard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.yellow, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/hobbseeme_score.png', height: 25),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 60, 10, 241),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text('Hive 1',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('233',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Image.asset('assets/cashback_icon.png', height: 55),
            ],
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 0.75,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 8),
          const Text('Earn 200 more points to get 50 AED cashback',
              style: TextStyle(
                  color: Colors.white, fontSize: 12, fontFamily: 'Poppins')),
        ],
      ),
    ),
  );
}

Widget _buildInfoGrid() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildInfoCard(
            value: '04',
            label: 'Bookings\n& Enrolments',
            icon: Icons.calendar_today_outlined,
            iconColor: const Color.fromARGB(255, 228, 128, 162),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildInfoCard(
                value: '7,678 AED',
                label: 'Wallet',
                icon: Icons.account_balance_wallet_outlined,
                iconColor: const Color.fromARGB(255, 228, 128, 162),
                isRow: true,
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                value: '02',
                label: 'Wishlist',
                icon: Icons.favorite_border,
                iconColor: const Color.fromARGB(255, 228, 128, 162),
                isRow: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard({
  required String value,
  required String label,
  required IconData icon,
  required Color iconColor,
  bool isRow = false,
}) {
  Widget content;
  if (isRow) {
    content = Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey[400])),
          ],
        ),
      ],
    );
  } else {
    content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(color: Colors.grey[400]),
            textAlign: TextAlign.center),
      ],
    );
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(20),
    ),
    child: content,
  );
}

Widget _buildAccountMenuList() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Account',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildMenuListItem(Icons.people_outline, 'My Circle',
            'A circle of loved ones boosts our resilience...'),
        _buildMenuListItem(Icons.star_border, 'Referral',
            'Join our referral program and earn rewards!'),
        _buildMenuListItem(Icons.notifications_none, 'Notification',
            'Stay updated with all the latest alerts'),
        _buildMenuListItem(Icons.card_giftcard, 'Offer a service',
            'Host fun workshops in Dubai!'),
        _buildMenuListItem(Icons.lock_outline, 'Change password',
            'Update your password here.'),
        _buildMenuListItem(Icons.favorite_border, 'Terms and Conditions',
            'Manage your trading view, trading options, etc'),
        _buildMenuListItem(
            Icons.help_outline, 'Help Center', 'Get help with your account'),
        _buildMenuListItem(Icons.policy_outlined, 'Privacy Policy',
            'Trade reports, TDS certificates & summary'),
        _buildMenuListItem(Icons.logout, 'Logout', ''),
      ],
    ),
  );
}

Widget _buildMenuListItem(IconData icon, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color.fromARGB(255, 60, 60, 45),
          child: Icon(icon, color: Colors.yellow),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              if (subtitle.isNotEmpty)
                Text(subtitle, style: TextStyle(color: Colors.grey[400])),
            ],
          ),
        ),
        if (title != 'Logout')
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ],
    ),
  );
}
