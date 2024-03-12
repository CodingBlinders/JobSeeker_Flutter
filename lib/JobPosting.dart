import 'package:flutter/material.dart';
import 'job_forms.dart';


class JobPosting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Page with Filters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
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
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search Jobs',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your filter button functionality here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Icon(Icons.filter_4),
            ),
          ),
        ], //Actions
      ),
      body: Padding(
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
                        MaterialPageRoute(builder: (context) => JobFormPage1()), // Using JobForms instead of JobForm
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(double.infinity, 50), // Set minimumSize to increase height
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

            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text('Search Results Here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


