import 'package:flutter/material.dart';
import 'package:jobseeker_madhack/components/filter_chip.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, dynamic> getSelectedFilters() {
    return {
      "category": _selectedCategory,
      "salaryRange": {"min": _expectedSalary, "max": _maxSalary},
      "tags": _selectedTags,
    };
  }

  String? _selectedCategory;
  String? _selectedLocation;
  String? _selectedIndustry;
  double _expectedSalary = 0.0;
  double _maxSalary = 100000.0;
  final List<String> _selectedTags = [];

  final List<String> _categories = [
    'All',
    'Design & Development',
    'Web Developement',
    'DataScience',
    'Technical lead',
    'Buisness analyst'
  ];
  final List<String> _tags = [
    'Remote',
    'Hybrid',
    'Fulltime',
    'Intern',
    'On-Site',
    'Senior',
    'Fullstack'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Industry',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(0.0), // Remove border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Adjust shadow color
                    offset:
                        const Offset(0.0, 3.0), // Adjust shadow offset (X, Y)
                    blurRadius: 3.0, // Adjust shadow blur radius
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  // Remove border
                  border: InputBorder.none,
                ),
                value: _selectedIndustry,
                hint: const Text('Web Developement'),
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(0.0), // Remove border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Adjust shadow color
                    offset:
                        const Offset(0.0, 3.0), // Adjust shadow offset (X, Y)
                    blurRadius: 3.0, // Adjust shadow blur radius
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  // Remove border
                  border: InputBorder.none,
                ),
                value: _selectedCategory,
                hint: const Text('Fintech'),
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(0.0), // Remove border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Adjust shadow color
                    offset:
                        const Offset(0.0, 3.0), // Adjust shadow offset (X, Y)
                    blurRadius: 3.0, // Adjust shadow blur radius
                  ),
                ],
              ),
              child: TextFormField(
                onChanged: (value) {
                  _selectedLocation = value;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Srilanka',
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Salary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            RangeSlider(
              values: RangeValues(
                _expectedSalary.toDouble(),
                _maxSalary.toDouble(),
              ), // Track the current salary selection
              min: 0.0,
              max: 100000, // Maximum salary
              divisions: 1000,
              labels: RangeLabels(
                _expectedSalary.toStringAsFixed(0),
                _maxSalary.toStringAsFixed(0),
              ), // Display current salary
              onChanged: (RangeValues values) => setState(() {
                _expectedSalary = values.start.roundToDouble();
                _maxSalary = values.end.roundToDouble();
              }),
            ),
            const SizedBox(height: 40),
            const Text(
              "Tags",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(_tags.length, (index) {
                return FilterChipWidget(
                  title: _tags[index],
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(
              context,
              getSelectedFilters(),
            );
          },
          label: const Text('Apply Filters'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
