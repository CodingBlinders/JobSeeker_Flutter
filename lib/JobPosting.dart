// import 'package:flutter/material.dart';
// import 'job_forms.dart';
//
// class JobPosting extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Search Page with Filters',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SearchPage(),
//     );
//   }
// }
//
// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 spreadRadius: 2,
//                 blurRadius: 10,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   // Implement search functionality
//                 },
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: const InputDecoration(
//                     hintText: 'Search Jobs',
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Add your filter button functionality here
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue, // background color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               child: const Icon(Icons.settings),
//             ),
//           ),
//         ], //Actions
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const JobFormPage1()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.blue, // background color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       minimumSize: const Size(double.infinity, 50), // Set minimumSize to increase height
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add,
//                           size: 36, // Set the size of the icon
//                         ),
//                         SizedBox(width: 8), // Space between icon and text
//                         Text(
//                           'Create a New Job',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//             Expanded(
//               child: JobSearchResultsPage(), // Replace with your job search results page
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // New Widget for Job Search Results Page
// class JobSearchResultsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Search Results Here'),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'JobCard.dart';

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
          title: Text('Job Details'),
        ),
        body: Center(
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
    );
  }
}




