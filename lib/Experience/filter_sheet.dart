import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int _selectedCategoryIndex = 0;

  final Set<int> _selectedSubCategories = {0, 1, 2};

  final List<String> _filterCategories = [
    'Sub-Category',
    'Price',
    'Location',
    'Day',
    'Time',
    'Class Type',
  ];

  final List<String> _subCategoryOptions = [
    'Art & Crafts',
    'Public Speaking',
    'YOGA & Meditation',
    'Kids Summer Camp',
    'Creative Writing'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Color(0xFF212121),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          _buildFilterContent(),
          const SizedBox(height: 20),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Filters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _selectedSubCategories.clear();
            });
          },
          child: Text(
            'Reset',
            style: TextStyle(
                color: Colors.yellow[700], fontFamily: 'Poppins', fontSize: 16),
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
            itemCount: _filterCategories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
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
                      _filterCategories[index],
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
        const VerticalDivider(color: Colors.white24, width: 1),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: _selectedCategoryIndex == 0
                ? _buildSubCategoryOptions()
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        'Please select ${_filterCategories[_selectedCategoryIndex]} categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubCategoryOptions() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _subCategoryOptions.length,
      itemBuilder: (context, index) {
        final isChecked = _selectedSubCategories.contains(index);
        return CheckboxListTile(
          title: Text(
            _subCategoryOptions[index],
            style: const TextStyle(color: Colors.white),
          ),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _selectedSubCategories.add(index);
              } else {
                _selectedSubCategories.remove(index);
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
            Navigator.pop(context);
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
