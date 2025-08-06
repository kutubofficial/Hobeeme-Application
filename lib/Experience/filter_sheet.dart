import 'package:flutter/material.dart';
import 'events_page.dart';

class FilterSheet extends StatefulWidget {
  final Future<List<SubCategory>>? subCategoriesFuture;

  const FilterSheet({
    super.key,
    this.subCategoriesFuture,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int _selectedFilterTypeIndex = 0;
  // This now stores the selected slugs.
  final Set<String> _selectedSubCategorySlugs = {};
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  final List<String> _filterTypes = [
    'Sub-Category',
    'Price',
    'Location',
    // 'Day',
    // 'Time',
    // 'Class Type',
  ];

  /// Resets all filters to their default values.
  void _resetFilters() {
    setState(() {
      _selectedSubCategorySlugs.clear();
      _currentRangeValues = const RangeValues(0, 1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        color: Color(0xFF212121),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(color: Colors.white24, height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildFilterContent(),
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
            child: _buildFooter(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _resetFilters,
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.yellow[700], fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filterTypes.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedFilterTypeIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilterTypeIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: isSelected
                            ? Colors.yellow[700]!
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      _filterTypes[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[400],
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const VerticalDivider(color: Colors.white24, thickness: 1, width: 24),
        Expanded(
          flex: 3,
          child: _buildFilterOptionsPanel(),
        ),
      ],
    );
  }

  Widget _buildFilterOptionsPanel() {
    switch (_selectedFilterTypeIndex) {
      case 0:
        return _buildSubCategoryOptions();
      case 1:
        return _buildPriceRange();
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              '${_filterTypes[_selectedFilterTypeIndex]} options here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
        );
    }
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 40),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 1000,
          divisions: 20,
          activeColor: Colors.yellow[700],
          inactiveColor: Colors.grey[700],
          labels: RangeLabels(
            'AED ${_currentRangeValues.start.round()}',
            'AED ${_currentRangeValues.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AED ${_currentRangeValues.start.round()}',
                  style: const TextStyle(color: Colors.white70)),
              Text('AED ${_currentRangeValues.end.round()}',
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSubCategoryOptions() {
    if (widget.subCategoriesFuture == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'Select a category to see sub-categories.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
      );
    }

    return FutureBuilder<List<SubCategory>>(
      future: widget.subCategoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'No sub-categories found.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          );
        }

        final subCategories = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subCategories.length,
          itemBuilder: (context, index) {
            final subCategory = subCategories[index];
            // Check if the slug is in the set.
            final isChecked =
                _selectedSubCategorySlugs.contains(subCategory.slug);

            return CheckboxListTile(
              title: Text(
                subCategory.name,
                style: const TextStyle(color: Colors.white),
              ),
              value: isChecked,
              // Add/remove the slug from the set.
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedSubCategorySlugs.add(subCategory.slug);
                  } else {
                    _selectedSubCategorySlugs.remove(subCategory.slug);
                  }
                });
              },
              activeColor: Colors.yellow[700],
              checkColor: Colors.black,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            );
          },
        );
      },
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '5,492',
              style: TextStyle(
                color: Colors.yellow[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Classes Found',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // Send the set of slugs back.
            final result = FilterResult(
              subCategorySlugs: _selectedSubCategorySlugs,
              priceRange: _currentRangeValues,
            );
            Navigator.pop(context, result);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A5AE0),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'APPLY',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
