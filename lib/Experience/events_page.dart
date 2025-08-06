import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'event_card.dart';
import 'filter_sheet.dart';
import 'categories_sheet.dart';

/// UPDATED: This class now holds the selected emirates.
class FilterResult {
  final Set<String> subCategorySlugs;
  final RangeValues priceRange;
  final Set<String> emirates;

  FilterResult({
    required this.subCategorySlugs,
    required this.priceRange,
    required this.emirates,
  });
}

class SubCategory {
  final String id;
  final String name;
  final String slug;
  final String parentId;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.parentId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unnamed Sub-Category',
      slug: json['category_slug'] ?? '',
      parentId: json['parentId'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Event {
  final String imageUrl;
  final String title;
  final String location;
  final String displayDate;
  final String category;
  final double price;
  final double originalPrice;
  final int slotsLeft;

  Event({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.displayDate,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.slotsLeft,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final double lowestPrice = (json['lowestPrice'] as num?)?.toDouble() ?? 0.0;
    final double highestDiscount =
        (json['highestDiscount'] as num?)?.toDouble() ?? 0.0;
    double originalPrice = lowestPrice;
    if (highestDiscount > 0 && highestDiscount < 100) {
      originalPrice = lowestPrice / (1 - (highestDiscount / 100));
    }

    final int maxSlots = (json['maxSlots'] as num?)?.toInt() ?? 0;
    final int totalBookedSlots =
        (json['totalBookedSlots'] as num?)?.toInt() ?? 0;
    final int slotsLeft = maxSlots - totalBookedSlots;

    String formattedDate = 'Date not available';
    final dateStr = json['exp_start_date'] as String?;
    final timeStr = json['exp_start_time'] as String?;
    if (dateStr != null && timeStr != null) {
      try {
        final fullDateTimeStr = '$dateStr $timeStr';
        final inputFormat = DateFormat('yyyy-MM-dd h:mm a', 'en_US');
        final dateTime = inputFormat.parse(fullDateTimeStr);
        final outputFormat = DateFormat('EEEE d MMM yyyy, hh:mm a', 'en_US');
        formattedDate = outputFormat.format(dateTime);
      } catch (e) {
        formattedDate = '$dateStr at $timeStr';
      }
    }

    return Event(
      imageUrl: json['cover_image'] ?? '',
      title: json['listing_name'] ?? 'No Title',
      location: json['listing_location_address'] ?? 'Location not specified',
      displayDate: formattedDate,
      category: json['categoryName'] ?? 'Uncategorized',
      price: lowestPrice,
      originalPrice: originalPrice,
      slotsLeft: slotsLeft > 0 ? slotsLeft : 0,
    );
  }
}

// --- MAIN WIDGET ---

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // --- STATE VARIABLES ---
  late Future<List<Event>> futureEvents;
  int _eventCount = 0;
  String _selectedCategoryName = 'All';
  String _selectedCategorySlug = 'all';

  // State variables to hold the selected filters
  Set<String> _selectedSubCategorySlugs = {};
  RangeValues _selectedPriceRange = const RangeValues(0, 1000);
  // NEW: State variable for selected locations
  Set<String> _selectedEmirates = {};

  Future<List<SubCategory>>? futureSubCategories;

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents(categorySlug: _selectedCategorySlug);
  }

  // --- API CALLS ---

  /// UPDATED: Function now accepts and sends the emirates filter.
  Future<List<Event>> fetchEvents({
    required String categorySlug,
    Set<String>? subCategorySlugs,
    RangeValues? priceRange,
    Set<String>? emirates,
  }) async {
    final url = Uri.parse(
        'https://catalog.hobbeeme.com/filter/vendor-experience-listing?page=1&limit=30');

    final Map<String, dynamic> requestBody = {};

    if (categorySlug != 'all') {
      requestBody['category'] = categorySlug;
    }

    if (subCategorySlugs != null && subCategorySlugs.isNotEmpty) {
      requestBody['sub_categories'] = subCategorySlugs.toList();
    }

    if (priceRange != null) {
      requestBody['price_range'] = [
        priceRange.start.round(),
        priceRange.end.round()
      ];
    }

    if (emirates != null && emirates.isNotEmpty) {
      requestBody['emirates'] = emirates.toList();
    }

    print('Request Body: ${jsonEncode(requestBody)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> items = jsonResponse['data']['data'];
      final events =
          items.map((eventJson) => Event.fromJson(eventJson)).toList();

      if (mounted) {
        setState(() {
          _eventCount = events.length;
        });
      }

      return events;
    } else {
      throw Exception(
          'Failed to load events. Status code: ${response.statusCode}\nBody: ${response.body}');
    }
  }

  Future<List<SubCategory>> fetchSubCategoriesBySlug(
      String categorySlug) async {
    if (categorySlug == 'all') {
      return [];
    }
    final url = Uri.parse(
        'https://catalog.hobbeeme.com/categories/get-category-by-slug/$categorySlug');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsedJson = jsonDecode(response.body);
      final List<dynamic> subCategoryItems =
          parsedJson['data']['subcategories'];
      return subCategoryItems
          .map((json) => SubCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load sub-categories for slug: $categorySlug');
    }
  }

  // --- UI ACTIONS ---

  void _showCategorySheet() async {
    final result = await showModalBottomSheet<CategoryItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CategoriesSheet(selectedCategorySlug: _selectedCategorySlug);
      },
    );

    if (result != null && result.slug != _selectedCategorySlug) {
      setState(() {
        _selectedCategoryName = result.name;
        _selectedCategorySlug = result.slug;
        _eventCount = 0;
        // Reset all filters when main category changes
        _selectedSubCategorySlugs = {};
        _selectedPriceRange = const RangeValues(0, 1000);
        _selectedEmirates = {};

        futureEvents = fetchEvents(categorySlug: _selectedCategorySlug);
        futureSubCategories = fetchSubCategoriesBySlug(_selectedCategorySlug);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: _showCategorySheet,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.grey.shade700, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.apps, color: Colors.yellow, size: 20),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _selectedCategoryName,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        leadingWidth: 120,
        title: Text(
          '$_eventCount Results',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white, size: 28),
            onPressed: () async {
              final result = await showModalBottomSheet<FilterResult>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => FilterSheet(
                  subCategoriesFuture: futureSubCategories,
                ),
              );

              if (result != null) {
                setState(() {
                  // UPDATED: Store all filters from the result.
                  _selectedSubCategorySlugs = result.subCategorySlugs;
                  _selectedPriceRange = result.priceRange;
                  _selectedEmirates = result.emirates;

                  // Re-fetch the events with all filters applied.
                  futureEvents = fetchEvents(
                    categorySlug: _selectedCategorySlug,
                    subCategorySlugs: _selectedSubCategorySlugs,
                    priceRange: _selectedPriceRange,
                    emirates: _selectedEmirates,
                  );
                });
              }
            },
          ),
          IconButton(
              icon: const Icon(Icons.calendar_month_outlined,
                  color: Colors.white, size: 26),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 28),
              onPressed: () {}),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Event>>(
          future: futureEvents,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (snapshot.hasData) {
              final events = snapshot.data!;
              if (events.isEmpty) {
                return const Text('No events found with the selected filters.',
                    style: TextStyle(color: Colors.white));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: EventCard(event: events[index]),
                  );
                },
              );
            } else {
              return const Text('No events found.',
                  style: TextStyle(color: Colors.white));
            }
          },
        ),
      ),
    );
  }
}
