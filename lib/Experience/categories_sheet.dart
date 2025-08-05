import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryItem {
  final String name;

  CategoryItem({required this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      name: json['name'] ?? 'Unnamed Category',
    );
  }
}

class CategoriesSheet extends StatefulWidget {
  final String selectedCategory;

  const CategoriesSheet({super.key, this.selectedCategory = 'All'});

  @override
  State<CategoriesSheet> createState() => _CategoriesSheetState();
}

class _CategoriesSheetState extends State<CategoriesSheet> {
  late Future<List<CategoryItem>> _futureCategories;
  late String _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.selectedCategory;
    _futureCategories = fetchCategories();
  }

  Future<List<CategoryItem>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://catalog.hobbeeme.com/categories?type=EXPERIENCE'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> items = jsonResponse['data'];

      List<CategoryItem> categories =
          items.map((item) => CategoryItem.fromJson(item)).toList();

      categories.insert(0, CategoryItem(name: 'All'));

      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'all':
        return Icons.apps;
      case 'creative & performing arts':
        return Icons.theater_comedy_outlined;
      case 'art, culture & expression':
        return Icons.palette_outlined;
      case 'food & culinary':
        return Icons.restaurant_menu_outlined;
      case 'wellness & lifestyle':
        return Icons.spa_outlined;
      case 'adventure & outdoors':
        return Icons.terrain_outlined;
      case 'community & networking':
        return Icons.people_outline;
      case 'camps':
        return Icons.fireplace_outlined;
      default:
        return Icons.more_horiz_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Categories',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.grey),
          const SizedBox(height: 16),
          FutureBuilder<List<CategoryItem>>(
            future: _futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ));
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red)));
              } else if (snapshot.hasData) {
                final categories = snapshot.data!;
                return Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  alignment: WrapAlignment.center,
                  children: categories.map((category) {
                    final isSelected = category.name == _currentSelection;
                    return OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _currentSelection = category.name;
                        });
                        Navigator.pop(context, category.name);
                      },
                      icon: Icon(
                        _getIconForCategory(category.name),
                        size: 20,
                        color: isSelected ? Colors.yellow : Colors.white,
                      ),
                      label: Text(
                        category.name,
                        style: TextStyle(
                          color: isSelected ? Colors.yellow : Colors.white,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isSelected
                            ? Colors.transparent
                            : Colors.transparent,
                        side: BorderSide(
                          color:
                              isSelected ? Colors.yellow : Colors.grey.shade600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                    child: Text('No categories found.',
                        style: TextStyle(color: Colors.white)));
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
