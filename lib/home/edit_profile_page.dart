import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _selectedGender = 'Male';
  String? _selectedNationality = 'Indian';
  String? _selectedCountry = 'UAE';
  String? _selectedEmirate = 'Abu dhabi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Profile',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(label: 'Name', initialValue: 'John Watson'),
            _buildDropdownField(
              label: 'Gender',
              value: _selectedGender,
              items: ['Male', 'Female', 'Other'],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            _buildDropdownField(
              label: 'Date of Birth',
              value: '2001-05-01',
              items: ['2001-05-01'],
              onChanged: (value) {},
            ),
            _buildTextField(
              label: 'Email Address',
              initialValue: 'John.Watson@gmail.com',
              isHighlighted: true,
            ),
            _buildTextField(
              label: 'Mobile Number (Optional)',
              initialValue: '(205) 555-0100',
              keyboardType: TextInputType.phone,
            ),
            _buildDropdownField(
              label: 'Nationality',
              value: _selectedNationality,
              items: ['Indian', 'American', 'British'],
              onChanged: (value) {
                setState(() {
                  _selectedNationality = value;
                });
              },
            ),
            _buildDropdownField(
              label: 'Country',
              value: _selectedCountry,
              items: ['UAE', 'USA', 'UK'],
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
            ),
            _buildDropdownField(
              label: 'Emirate',
              value: _selectedEmirate,
              items: ['Abu dhabi', 'Dubai', 'Sharjah'],
              onChanged: (value) {
                setState(() {
                  _selectedEmirate = value;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 95, 26, 233),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Save',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    bool isHighlighted = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialValue,
            style: const TextStyle(color: Colors.white),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1C1C1E),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: isHighlighted ? Colors.yellow : Colors.grey.shade800,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.yellow),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: const Color(0xFF2C2C2E),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1C1C1E),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade800),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.yellow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
