import 'package:flutter/material.dart';

// This is the complete code for your new Class Listings Page.
// Save this in a file named class_listings_page.dart

class ClassListingsPage extends StatefulWidget {
  const ClassListingsPage({super.key});

  @override
  State<ClassListingsPage> createState() => _ClassListingsPageState();
}

class _ClassListingsPageState extends State<ClassListingsPage> {
  // This manages which of the top 4 buttons is selected
  String _selectedCategory = 'CLASSES';

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(), // Standard back button
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: Colors.yellow, size: 20),
            SizedBox(width: 8),
            Text('Jumaira beach residency, Dubai',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The top bar with Hobeeme, Classes, Experiences, Events
          _TopCategoryBar(
            selectedCategory: _selectedCategory,
            onCategorySelected: _onCategorySelected,
          ),
          // The filter bar below it
          _FilterBar(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('21 Results', style: TextStyle(color: Colors.white)),
          ),
          // The list of class cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: const [
                _ListingCard(
                  imagePath: 'assets/dance_listing_1.png',
                  title: 'Dance Sessions',
                  subtitle: 'BY Taal Performing Arts',
                  tags: ['Hip Hop', 'Belle Dance', 'Solo', 'Contemp'],
                ),
                _ListingCard(
                  imagePath: 'assets/dance_listing_2.png',
                  title: 'Dance Sessions',
                  subtitle: 'BY DD Dance Studio DXB',
                  tags: ['Hip Hop', 'Belle Dance', 'Solo', 'Contemp'],
                ),
                _ListingCard(
                  imagePath: 'assets/art_listing_1.png',
                  title: 'Art & Craft Sessions',
                  subtitle: 'BY Ananta_artz - Vidya',
                  tags: ['DRAWING', 'PAINTING', 'DIY', 'POTTERY'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// A widget for the top category selection bar
class _TopCategoryBar extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const _TopCategoryBar(
      {required this.selectedCategory, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryButton('HOBBSEEME', 'assets/logo.png', context),
          _buildCategoryButton('CLASSES', 'assets/classes_logo.png', context),
          _buildCategoryButton(
              'EXPERIENCES', 'assets/experience_logo.png', context),
          _buildCategoryButton('EVENTS', 'assets/event_logo.png', context),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      String text, String assetPath, BuildContext context) {
    final isSelected = selectedCategory == text;
    return Expanded(
      child: GestureDetector(
        onTap: () => onCategorySelected(text),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(8),
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Colors.pinkAccent : const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

// A widget for the filter bar
class _FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.apps, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text('All', style: TextStyle(color: Colors.white)),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          Row(
            children: [
              _buildFilterIcon(Icons.swap_vert),
              _buildFilterIcon(Icons.filter_list),
              _buildFilterIcon(Icons.calendar_today_outlined),
              _buildFilterIcon(Icons.refresh),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(icon, color: Colors.white),
    );
  }
}

// A widget for a single class listing card
class _ListingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final List<String> tags;

  const _ListingCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(imagePath,
                    fit: BoxFit.cover, width: double.infinity, height: 180),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Text('4 ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Icon(Icons.star, color: Colors.yellow, size: 14),
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 12,
                right: 12,
                child: Text('Only 50 Slots Left!',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 16),
                    SizedBox(width: 4),
                    Text('Dubai', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('AED 456',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text('Onwards', style: TextStyle(color: Colors.grey[400])),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: tags
                      .map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: const Color(0xFF2C2C2E),
                            labelStyle: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
