import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Map<String, Map<String, List<Map<String, String>>>> _allCategoryData = {
    'ART & CULTURE': {
      'CLASSES CATEGORIES': [
        {'image': 'assets/art2.png', 'title': 'ART & CRAFT'},
        {'image': 'assets/art2.png', 'title': 'ART & CRAFT'},
        {'image': 'assets/art2.png', 'title': 'ART & CRAFT'},
        {'image': 'assets/cooking2.png', 'title': 'COOKING'},
        {'image': 'assets/cooking2.png', 'title': 'COOKING'},
        {'image': 'assets/cooking2.png', 'title': 'COOKING'},
        {'image': 'assets/dance_logo2.png', 'title': 'DANCE'},
        {'image': 'assets/dance_logo2.png', 'title': 'DANCE'},
        {'image': 'assets/dance_logo2.png', 'title': 'DANCE'},
      ],
      'EXPERIENCE ZONES': [
        {'image': 'assets/kids.png', 'title': 'KIDS'},
        {'image': 'assets/couple.png', 'title': 'COUPLES'},
        {'image': 'assets/adventure.png', 'title': 'ADVENTURE'},
        {'image': 'assets/kids.png', 'title': 'KIDS'},
        {'image': 'assets/couple.png', 'title': 'COUPLES'},
        {'image': 'assets/adventure.png', 'title': 'ADVENTURE'},
      ],
    },
    'MUSIC': {
      'CLASSES CATEGORIES': [],
      'EXPERIENCE ZONES': [],
    },
    'DANCE': {
      'CLASSES CATEGORIES': [],
      'EXPERIENCE ZONES': [],
    },
    'SPORTS & FITNESS': {
      'CLASSES CATEGORIES': [],
    },
    'WELLNESS & LIFESTYLE': {},
    'FOOD & CULINARY': {},
    'DIGITAL SKILLS': {},
    'ADVENTURE & OUTDOORS': {},
    'COMMUNITY & NETWORKING': {},
    'CAMPS': {},
    'OTHER SKILL & DEVELOPMENT': {},
  };

  late final List<String> _categoryNames;
  String _selectedCategory = 'ART & CULTURE';

  @override
  void initState() {
    super.initState();
    _categoryNames = _allCategoryData.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> selectedData;

    if (_selectedCategory == 'ART & CULTURE') {
      final allClassCategories = <Map<String, String>>[];
      final allExperienceZones = <Map<String, String>>[];

      for (var categoryData in _allCategoryData.values) {
        allClassCategories.addAll(categoryData['CLASSES CATEGORIES'] ?? []);
        allExperienceZones.addAll(categoryData['EXPERIENCE ZONES'] ?? []);
      }

      selectedData = {
        'CLASSES CATEGORIES': allClassCategories,
        'EXPERIENCE ZONES': allExperienceZones,
      };
    } else {
      selectedData = _allCategoryData[_selectedCategory] ?? {};
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    Image.asset('assets/category_cover2.png'),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Ad',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: _buildCategoryList(),
                  ),
                  Expanded(
                    child: _CategoryContent(data: selectedData),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      itemCount: _categoryNames.length,
      itemBuilder: (context, index) {
        final category = _categoryNames[index];
        final isSelected = category == _selectedCategory;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.yellow : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontFamily: 'Poppins',
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryContent extends StatelessWidget {
  final Map<String, List<Map<String, String>>> data;
  const _CategoryContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final classes = data['CLASSES CATEGORIES'] ?? [];
    final experiences = data['EXPERIENCE ZONES'] ?? [];

    if (classes.isEmpty && experiences.isEmpty) {
      return const Center(
        child: Text(
          'No content available for this category.',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            if (classes.isNotEmpty) ...[
              const _SectionHeader(title: 'CLASSES CATEGORIES'),
              _CategoryGrid(items: classes, useColoredBackgrounds: true),
            ],
            if (experiences.isNotEmpty) ...[
              const _SectionHeader(title: 'EXPERIENCE ZONES'),
              _CategoryGrid(items: experiences),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<Map<String, String>> items;
  final bool useColoredBackgrounds;

  const _CategoryGrid({
    required this.items,
    this.useColoredBackgrounds = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue.shade700,
      Colors.pink.shade400,
      Colors.green.shade600,
      Colors.purple.shade400,
      Colors.orange.shade600,
      Colors.teal.shade600,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final color = useColoredBackgrounds
            ? colors[index % colors.length]
            : Colors.transparent;

        return _CategoryGridItem(
          imagePath: item['image']!,
          title: item['title']!,
          backgroundColor: color,
        );
      },
    );
  }
}

class _CategoryGridItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color backgroundColor;

  const _CategoryGridItem({
    required this.imagePath,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
