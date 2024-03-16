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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.rotate_right_sharp),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
          ),
        ],
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
}
