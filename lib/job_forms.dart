import 'package:flutter/material.dart';
import 'components/page_indicator.dart';

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

      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Indicator
            PageIndicator(
              currentPage: 0,
              totalPages: 4,
            ),
            const Center(
              child: Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                textAlign: TextAlign.center, // Optional: to center the text horizontally
              ),
            ),
            const SizedBox(height: 20), // Add some space between page indicator and form fields
            // Industry Dropdown
            Text(
              'Industry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Industry',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Category Dropdown
            Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Category',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Job Position',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Job Position',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Job Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              items: <String>['Full Time', 'Part Time']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Job Type',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Type of Workspace',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              items: <String>['Onsite', 'Online']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Workspace Type',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) => JobFormPage2(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Next'),
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
            const Text(
              'Search Locations',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) => const JobFormPage3(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Next'),
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
            const Text(
              'Select Price Range',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
            SizedBox(height: 20),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: 200,
                  margin: EdgeInsets.only(bottom: 20), // 20px above the bottom
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (context, animation, secondaryAnimation) => FinalJobPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text('Next',
                      style: TextStyle(color: Colors.white),
                    ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Final Job Form',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(height: 20),
            _buildLabeledTextField('Job Description'),
            SizedBox(height: 20),
            _buildLabeledTextField('Requirements'),
            SizedBox(height: 20),
            _buildLabeledTextField('Responsibilities'),
            SizedBox(height: 20),
            _buildLabeledTextField('About Company'),
            SizedBox(height: 20),
            Spacer(), // Added Spacer to push the button to the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20), // 20px above the bottom
                child: ElevatedButton(
                  onPressed: () {
                    // Perform any action needed on button press
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text(
                    'Submit',
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
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent, // Set the border color to transparent
                ),
              ),
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}


