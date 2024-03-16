import 'package:flutter/material.dart';
import 'components/page_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'components/shadowDropDown.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const apiUrl = "http://madhack.codingblinders.com//job/create/";

class FormData {
  final String industry;
  final String title;
  final String category;
  final String jobPosition;
  final String jobType;
  final String workspaceType;
  final String location;
  final int minPrice;
  final int maxPrice;
  late String jobDescription;
  late String requirements;
  late String responsibilities;
  late String aboutCompany;

  FormData({
    required this.industry,
    required this.title,
    required this.category,
    required this.jobPosition,
    required this.jobType,
    required this.workspaceType,
    required this.location,
    required this.minPrice,
    required this.maxPrice,
    required this.jobDescription,
    required this.requirements,
    required this.responsibilities,
    required this.aboutCompany,
  });

  Map<String, dynamic> toJson() {
    return {
      'Industry': industry,
      'title': title,
      'Category': category,
      'JobPosition': jobPosition,
      'jobType': jobType,
      'TypeOfWorkspace': workspaceType,
      'location': location,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'description': jobDescription,
      'requirements': requirements,
      'responsibilities': responsibilities,
      'aboutCompany': aboutCompany,
    };
  }

  FormData copyWith({
    String? industry,
    String? title,
    String? category,
    String? jobPosition,
    String? jobType,
    String? workspaceType,
    String? location,
    int? minPrice,
    int? maxPrice,
    String? jobDescription,
    String? requirements,
    String? responsibilities,
    String? aboutCompany,
  }) {
    return FormData(
      industry: industry ?? this.industry,
      title: title ?? this.title,
      category: category ?? this.category,
      jobPosition: jobPosition ?? this.jobPosition,
      jobType: jobType ?? this.jobType,
      workspaceType: workspaceType ?? this.workspaceType,
      location: location ?? this.location,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      jobDescription: jobDescription ?? this.jobDescription,
      requirements: requirements ?? this.requirements,
      responsibilities: responsibilities ?? this.responsibilities,
      aboutCompany: aboutCompany ?? this.aboutCompany,
    );
  }
}


class JobFormPage1 extends StatefulWidget {
  const JobFormPage1({Key? key}) : super(key: key);

  @override
  _JobFormPage1State createState() => _JobFormPage1State();
}

class _JobFormPage1State extends State<JobFormPage1> {
  late TextEditingController titleController;
  late TextEditingController jobPositionController;
  late TextEditingController jobDescriptionController;
  late TextEditingController requirementsController;
  late TextEditingController responsibilitiesController;
  late TextEditingController aboutCompanyController;

  String selectedIndustry = 'Design and Development';
  String? selectedCategory = 'UI/UX design';
  String? selectedJobType;
  String? selectedWorkspaceType;
  String? selectedLocation;
  int minPrice = 0;
  int maxPrice = 50000;

  Map<String, List<String>> categoriesMap = {
    'Design and Development': ['UI/UX design', 'Frontend developer', 'Backend developer', 'DevOps developer'],
    'Marketing': ['Digital Marketing', 'Content Writing', 'SEO Specialist'],
    'Finance': ['Accounting', 'Financial Analyst', 'Investment Banking'],
  };

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    jobPositionController = TextEditingController();
    jobDescriptionController = TextEditingController();
    requirementsController = TextEditingController();
    responsibilitiesController = TextEditingController();
    aboutCompanyController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    jobPositionController.dispose();
    jobDescriptionController.dispose();
    requirementsController.dispose();
    responsibilitiesController.dispose();
    aboutCompanyController.dispose();
    super.dispose();
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
            const Center(
              child: Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Industry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
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
                    selectedCategory = null;
                  });
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: titleController,
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
            Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
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
            Text(
              'Job Position',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: jobPositionController,
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
            Text(
              'Job Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
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
                onChanged: (String? value) {
                  setState(() {
                    selectedJobType = value!;
                  });
                },
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
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
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
                onChanged: (String? value) {
                  setState(() {
                    selectedWorkspaceType = value!;
                  });
                },
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
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    FormData formData = FormData(
                      industry: selectedIndustry,
                      title: titleController.text,
                      category: selectedCategory!,
                      jobPosition: jobPositionController.text,
                      jobType: selectedJobType!,
                      workspaceType: selectedWorkspaceType!,
                      location: selectedLocation ?? "",
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                      jobDescription: jobDescriptionController.text,
                      requirements: requirementsController.text,
                      responsibilities: responsibilitiesController.text,
                      aboutCompany: aboutCompanyController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobFormPage2(formData: formData)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
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
  final FormData formData;

  const JobFormPage2({Key? key, required this.formData}) : super(key: key);

  @override
  _JobFormPage2State createState() => _JobFormPage2State();
}

class _JobFormPage2State extends State<JobFormPage2> {
  late TextEditingController _searchController;
  List<String> _suggestions = [];
  String _selectedLocation = '';
  bool _showSuggestions = true;

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

  void getSuggestions(String query) {
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
            const Center(
              child: Text(
                "Search Locations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
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
                  getSuggestions(value);
                  setState(() {
                    _showSuggestions = true;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            if (_showSuggestions)
              Expanded(
                child: ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_suggestions[index]),
                      onTap: () {
                        setState(() {
                          _selectedLocation = _suggestions[index];
                          _searchController.text = _selectedLocation;
                          _showSuggestions = false;
                        });
                      },
                    );
                  },
                ),
              ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobFormPage3(formData: widget.formData.copyWith(location: _selectedLocation))),
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
  final FormData formData;

  const JobFormPage3({Key? key, required this.formData}) : super(key: key);

  @override
  _JobFormPage3State createState() => _JobFormPage3State();
}

class _JobFormPage3State extends State<JobFormPage3> {
  RangeValues _values = const RangeValues(0, 50000);

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
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinalJobPage(formData: widget.formData.copyWith(minPrice: _values.start.toInt(), maxPrice: _values.end.toInt()))),
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



class FinalJobPage extends StatefulWidget {
  final FormData formData;

  const FinalJobPage({Key? key, required this.formData}) : super(key: key);

  @override
  _FinalJobPageState createState() => _FinalJobPageState();
}

class _FinalJobPageState extends State<FinalJobPage> {
  // Define controllers for each text field
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController responsibilitiesController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with initial values
    jobDescriptionController.text = widget.formData.jobDescription;
    requirementsController.text = widget.formData.requirements;
    responsibilitiesController.text = widget.formData.responsibilities;
    aboutCompanyController.text = widget.formData.aboutCompany;
  }

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
                    _buildLabeledTextField('Job Description', jobDescriptionController),
                    SizedBox(height: 20),
                    _buildLabeledTextField('Requirements', requirementsController),
                    SizedBox(height: 20),
                    _buildLabeledTextField('Responsibilities', responsibilitiesController),
                    SizedBox(height: 20),
                    _buildLabeledTextField('About Company', aboutCompanyController),
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
                // Perform API call on button press
                _submitData(widget.formData);
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

  Widget _buildLabeledTextField(String label, TextEditingController controller) {
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
              controller: controller,
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

  void _submitData(FormData formData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    formData.jobDescription = jobDescriptionController.text;
    String requirements = requirementsController.text;
    String responsibilities = responsibilitiesController.text;
    formData.aboutCompany = aboutCompanyController.text;

    List<String> requirementsArray = requirements.split('\n');
    List<String> responsibilitiesArray = responsibilities.split('\n');

    final jsonData = formData.toJson();

    jsonData['requirements'] = requirementsArray;
    jsonData['responsibilities'] = responsibilitiesArray;

    Map<String, dynamic> salaryRange = {
      'low': jsonData['minPrice'],
      'high': jsonData['maxPrice'],
    };
    jsonData.remove('minPrice');
    jsonData.remove('maxPrice');
    jsonData.remove('currency');
    jsonData['salaryRange'] = salaryRange;

    final encodedData = jsonEncode(jsonData);

    print(encodedData);

    const apiUrl = 'http://madhack.codingblinders.com/job/create';
    // const apiUrl = 'http://localhost:4000/api/job/create';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: encodedData,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': userToken!, // Add the token to the header
      },
    );

    if (response.statusCode == 200) {

      print('Data submitted successfully');
    } else {
      // Handle failure
      print('Failed to submit data. Error code: ${response.body}');
    }
  }
}
