import 'package:flutter/material.dart';

class EnterAddressDetailsScreen extends StatefulWidget {
  const EnterAddressDetailsScreen({super.key});

  @override
  State<EnterAddressDetailsScreen> createState() =>
      _EnterAddressDetailsScreenState();
}

enum AddressTag { home, others }

class _EnterAddressDetailsScreenState extends State<EnterAddressDetailsScreen> {
  AddressTag _selectedTag = AddressTag.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enter Address Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* "Tag This Location" section
                  const Text(
                    'Tag This Location For later',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      TagButton(
                        text: 'Home',
                        icon: Icons.home_outlined,
                        isSelected: _selectedTag == AddressTag.home,
                        onTap: () {
                          setState(() {
                            _selectedTag = AddressTag.home;
                          });
                        },
                      ),
                      const SizedBox(width: 12),
                      TagButton(
                        text: 'Others',
                        icon: Icons.location_on_outlined,
                        isSelected: _selectedTag == AddressTag.others,
                        onTap: () {
                          setState(() {
                            _selectedTag = AddressTag.others;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  //* This is the conditional field that appears only when 'Others' is selected.
                  if (_selectedTag == AddressTag.others)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saved Address as',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        const CustomTextField(hintText: 'Studio'),
                        const SizedBox(height: 24),
                      ],
                    ),

                  //! "Current Location" section
                  const Text(
                    'Current Location',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Unnamed road, palm jumeirah',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(height: 4),
                              Text('Dubai',
                                  style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Change',
                              style: TextStyle(color: Colors.yellow[700])),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  //~ "Enter Your Complete Address" section
                  const Text(
                    'Enter Your Complete Address*',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  const CustomTextField(
                    hintText: 'C-40, floor 5th, block b, tower c',
                  ),
                ],
              ),
            ),
          ),

          //! This is the "SAVE & CONTINUE" button at the bottom.
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Not available yet...'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 48, 39, 236),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SAVE & CONTINUE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//* A reusable widget for our styled TextFields to avoid repeating code.
class CustomTextField extends StatelessWidget {
  final String hintText;
  const CustomTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

//* A reusable widget for the toggle buttons ('Home' and 'Others').
class TagButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const TagButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF8A2BE2), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
