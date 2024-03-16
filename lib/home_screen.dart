import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobseeker_madhack/components/JobCard.dart';
import 'package:jobseeker_madhack/components/filter_chip.dart';
import 'package:jobseeker_madhack/components/item_card.dart';
import 'package:jobseeker_madhack/components/scroll_cards.dart';
import 'package:jobseeker_madhack/components/search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:jobseeker_madhack/job_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> jobData = [];
  Future<void> _fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('userToken');

      final response = await http.get(
        Uri.parse('http://madhack.codingblinders.com/job/all'),
        headers: {
          'x-access-token': userToken ?? '', // Add userToken as a header
        },
      );
      final responseData = json.decode(response.body);
      setState(() {
        jobData = responseData['data'];
        print(jobData);
      });
    } catch (error) {
      print('Error fetching jobs: $error');
    }
  }

  List<Widget> widgetCards = [
    ItemCard(),
    ItemCard(),
    ItemCard(),
    ItemCard(),
  ];

  List<String> categories = [
    'All',
    'Design & Development',
    'Web Developement',
    'DataScience',
    'Technical lead',
    'Buisness analyst'
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
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
                    Navigator.pushNamed(context, '/profile');
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(25),
            child: CustomSearchBar(),
          ),
          // const SizedBox(
          //   height: 40,
          // ),

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: jobData.length,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) => JobCard(job: jobData[index]),
          //   ),
          // ),
          ScrollCardWidget(
            childrenList: categories
                .map(
                  (title) => FilterChipWidget(title: title),
                )
                .toList(),
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: jobData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobView(data: jobData[index]['_id']),
                        ),
                      );
                    },
                    child: JobCard(
                      job: jobData[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}
