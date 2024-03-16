import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'JobCard.dart';
import 'job_forms.dart';
import 'login.dart';

void main() {
  runApp(JobPosting());
}

class JobPosting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => _JobPostingState(),
          );
        },
      ),
    );
  }
}

class _JobPostingState extends StatefulWidget {
  @override
  __JobPostingStateState createState() => __JobPostingStateState();
}

class __JobPostingStateState extends State<_JobPostingState> {
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 40,
                        ),
                        radius: 45,
                      ),
                      SizedBox(height: 10),
                      FutureBuilder<String?>(
                        future: _getUserEmail(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error loading email');
                          } else {
                            return Text(
                              snapshot.data ?? 'Testing Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    // Handle home navigation
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    // Handle profile navigation
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Handle settings navigation
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.request_quote),
                  title: const Text('Requests'),
                  onTap: () {
                    // Handle requests navigation
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () {
                _clearSharedPreferences();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
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
                          print("Button pressed!");
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
                              size: 36,
                            ),
                            SizedBox(width: 8),
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
          const SizedBox(height: 10),
          const Text(
            "Recently Created Jobs",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
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
    );
  }

  Future _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}
