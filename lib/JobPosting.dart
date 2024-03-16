import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'JobCard.dart';
import 'job_forms.dart';

void main() {
  runApp(JobPosting());
}

class JobPosting extends StatefulWidget {
  @override
  _JobPostingState createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  List<dynamic> jobs = [];

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('userToken');
      String? userId = prefs.getString('userId');

      final response = await http.get(
        Uri.parse('http://madhack.codingblinders.com/job/employer/$userId'),
        headers: {
          'x-access-token': userToken ?? '', // Add userToken as a header
        },
      );
      final responseData = json.decode(response.body);
      setState(() {
        jobs = responseData['data'];
      });
    } catch (error) {
      print('Error fetching jobs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(

        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Implement search functionality
                    },
                  ),
                  const Expanded(
                    child: TextField(
                      // controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Jobs',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const JobFormPage1()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: const Size(double.infinity, 50), // Set minimumSize to increase height
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 36, // Set the size of the icon
                              ),
                              SizedBox(width: 8), // Space between icon and text
                              Text(
                                'Create a New Job',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    return JobCard(
                      job: jobs[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




