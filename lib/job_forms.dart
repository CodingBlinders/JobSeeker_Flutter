import 'package:flutter/material.dart';
import 'components/page_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'components/shadowDropDown.dart';

class JobFormPage1 extends StatefulWidget {
  const JobFormPage1({Key? key}) : super(key: key);

  @override
  _JobFormPage1State createState() => _JobFormPage1State();
}

class _JobFormPage1State extends State<JobFormPage1> {
  String selectedIndustry = 'Design and Development';
  String? selectedCategory = 'UI/UX design';

  Map<String, List<String>> categoriesMap = {
    'Design and Development': ['UI/UX design', 'Frontend developer', 'Backend developer', 'DevOps developer'],
    'Marketing': ['Digital Marketing', 'Content Writing', 'SEO Specialist'],
    'Finance': ['Accounting', 'Financial Analyst', 'Investment Banking'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: PageIndicator(
                currentPage: 0,
                totalPages: 4,
              ),
            ),

            const Center(
              child: Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),

            const SizedBox(height: 20), // Add some space between page indicator and form fields
            // Industry Dropdown
            const Text(
              'Industry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
                borderRadius: BorderRadius.circular(5.0), // Add border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedIndustry,
                items: <String>['Design and Development', 'Marketing', 'Finance']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedIndustry = value!;
                    selectedCategory = null; // Reset category when industry changes
                  });
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent, // Set to transparent to let Container handle background color
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            // Category Dropdown
            Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
                borderRadius: BorderRadius.circular(5.0), // Add border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                items: selectedIndustry.isNotEmpty
                    ? categoriesMap[selectedIndustry]!.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
                    : [],
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            const Text(
              'Job Position',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
                borderRadius: BorderRadius.circular(5.0), // Add border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Job Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
              borderRadius: BorderRadius.circular(5.0), // Add border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 3),
                ),
              ],
            ),
              child: DropdownButtonFormField<String>(
                items: <String>['Full Time', 'Part Time']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Type of Workspace',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
                borderRadius: BorderRadius.circular(5.0), // Add border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                items: <String>['Onsite', 'Online']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Spacer(), // Added Spacer to push the button to the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20), // 20px above the bottom
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobFormPage2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
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

class JobFormPage2 extends StatefulWidget {
  const JobFormPage2({Key? key}) : super(key: key);

  @override
  _JobFormPage2State createState() => _JobFormPage2State();
}

class _JobFormPage2State extends State<JobFormPage2> {
  late TextEditingController _searchController;
  List<String> _suggestions = []; // List of suggestions based on user input
  String _selectedLocation = ''; // Selected location
  bool _showSuggestions = true; // Boolean to control whether to show suggestions or not

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to get suggestions based on user input
  void getSuggestions(String query) {
    // In this example, it's just a dummy list of suggestions, you might fetch real suggestions from an API
    List<String> dummySuggestions = [
      'New York',
      'Los Angeles',
      'London',
      'Paris',
      'Tokyo',
      'Berlin',
      'Sydney',
      'Singapore',
    ];

    setState(() {
      _suggestions = dummySuggestions
          .where((location) => location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageIndicator(
              currentPage: 1,
              totalPages: 4,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Search Locations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Enter Location',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.search,
                    size: 36,
                  ),
                ),
                onChanged: (value) {
                  // Call the function to get suggestions whenever the text changes
                  getSuggestions(value);
                  // Show suggestions
                  setState(() {
                    _showSuggestions = true;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Only show suggestions if the boolean is true
            if (_showSuggestions)
              Expanded(
                child: ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_suggestions[index]),
                      onTap: () {
                        // Set the selected location when a suggestion is tapped
                        setState(() {
                          _selectedLocation = _suggestions[index];
                          // Update text field with selected location
                          _searchController.text = _selectedLocation;
                          // Hide suggestions
                          _showSuggestions = false;
                        });
                      },
                    );
                  },
                ),
              ),
            Spacer(), // Added Spacer to push the button to the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20), // 20px above the bottom
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobFormPage3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
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

class JobFormPage3 extends StatefulWidget {
  const JobFormPage3({Key? key}) : super(key: key);

  @override
  _JobFormPage3State createState() => _JobFormPage3State();
}

class _JobFormPage3State extends State<JobFormPage3> {
  RangeValues _values = const RangeValues(0, 50000); // Initial values for the price range

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageIndicator(
              currentPage: 2,
              totalPages: 4,
            ),
            const Center(
              child: Text(
                "Select Price Range",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 40),
            RangeSlider(
              values: _values,
              min: 0,
              max: 50000,
              divisions: 1000,
              onChanged: (values) {
                setState(() {
                  _values = values;
                });
              },
              labels: RangeLabels(
                '\$${(_values.start ~/ 1000)}k',
                '\$${(_values.end ~/ 1000)}k',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Minimum'),
                    SizedBox(height: 8),
                    Text('\$${(_values.start ~/ 1000)}k', style: TextStyle(fontSize: 18)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Maximum'),
                    SizedBox(height: 8),
                    Text('\$${(_values.end ~/ 1000)}k', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            Spacer(), // Added Spacer to push the button to the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20), // 20px above the bottom
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinalJobPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
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


class FinalJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageIndicator(
                      currentPage: 3,
                      totalPages: 4,
                    ),
                    const Center(
                      child: Text(
                        "Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildLabeledTextField('Job Description'),
                    SizedBox(height: 20),
                    _buildLabeledTextField('Requirements'),
                    SizedBox(height: 20),
                    _buildLabeledTextField('Responsibilities'),
                    SizedBox(height: 20),
                    _buildLabeledTextField('About Company'),
                    SizedBox(height: 20), // Add some extra space at the end
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // Perform any action needed on button press
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
            borderRadius: BorderRadius.circular(5.0), // Add border radius
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 20,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FinalJobPage(),
  ));
}
