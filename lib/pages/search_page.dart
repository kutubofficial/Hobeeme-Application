import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                      decoration: InputDecoration(
                        hintText: 'Search for area, street Name ...',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 17),
                        filled: true,
                        fillColor: const Color(0xFF2C2C2E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        suffixIcon: Icon(Icons.close, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on_outlined,
                        size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectLocationScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recently Classes',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 20),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              const DanceClassItem(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                        ),
                        const SizedBox(height: 30),
                        const Text('Recently Experiences',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 20),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              const DanceClassItem(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DanceClassItem extends StatelessWidget {
  const DanceClassItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF3A302B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const Icon(Icons.person, size: 40, color: Color(0xFFEFE0D9)),
          ),
        ),
        const SizedBox(width: 16),
        const Text('Salsa dance by DD Studio',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        size: 28, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Select Your Locations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextField(
                          style: TextStyle(color: Colors.white, fontSize: 17),
                          decoration: InputDecoration(
                            hintText: 'Search for area, street Name ...',
                            hintStyle: TextStyle(
                                color: Color(0xFF8E8E93), fontSize: 17),
                            filled: true,
                            fillColor: Color(0xFF1C1C1E),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                            prefixIcon:
                                Icon(Icons.search, color: Color(0xFF8E8E93)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        LocationOptionTile(
                            icon: Icons.add,
                            text: 'Add address',
                            iconColor: Colors.yellow[700]!),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConfirmAddressScreen()),
                            );
                          },
                          child: LocationOptionTile(
                            icon: Icons.my_location,
                            text: 'Use your current loaction',
                            iconColor: Colors.yellow[700]!,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text('Saved Address',
                            style: TextStyle(
                                color: Color(0xFF8E8E93), fontSize: 15)),
                        const SizedBox(height: 16),
                        SavedAddressCard(
                            icon: Icons.home_outlined,
                            title: 'Home',
                            subtitle: 'Unnamed road, palm jumeirah Dubai',
                            isSelected: true),
                        const SizedBox(height: 12),
                        SavedAddressCard(
                            icon: Icons.location_on_outlined,
                            title: 'Others',
                            subtitle: 'Add other address',
                            isSelected: false),
                        const SizedBox(height: 30),
                        const Text('Nearby locations',
                            style: TextStyle(
                                color: Color(0xFF8E8E93), fontSize: 15)),
                        const SizedBox(height: 16),
                        const NearbyLocationTile(
                            name: 'webninjaz',
                            address:
                                'C40, C Block, Sector 58, Noida, Uttar Pradesh 201301'),
                        const SizedBox(height: 12),
                        const NearbyLocationTile(
                            name: 'webninjaz',
                            address:
                                'Plot No. 45, Block C, Sector 63, Noida, Uttar Pradesh 201301'),
                        const SizedBox(height: 12),
                        const NearbyLocationTile(
                            name: 'Supertech',
                            address:
                                'Flat No. 1201, Tower 5, Supertech Capetown, Sector 74, Noida, Uttar Pradesh 201304'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationOptionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const LocationOptionTile(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}

class SavedAddressCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;

  const SavedAddressCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: const Color(0xFF8A2BE2), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, color: Colors.white)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style:
                      const TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}

class NearbyLocationTile extends StatelessWidget {
  final String name;
  final String address;

  const NearbyLocationTile(
      {super.key, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFF2C2C2E), width: 1))),
      child: Row(
        children: [
          const Icon(Icons.location_pin, color: Color(0xFF8E8E93), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(height: 4),
                Text(address,
                    style: const TextStyle(
                        color: Color(0xFF8E8E93), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmAddressScreen extends StatelessWidget {
  const ConfirmAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Address'),
      ),
      body: const Center(
        child: Text('Confirm Address Screen'),
      ),
    );
  }
}
