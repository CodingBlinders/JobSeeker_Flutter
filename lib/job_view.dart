import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';



class JobView extends StatefulWidget {
  @override
  _JobView createState() => _JobView();
}

class _JobView extends State<JobView> {
  Map<String, dynamic>? jobData;

  @override
  void initState() {
    super.initState();
    fetchJobData();
  }

  Future<void> fetchJobData() async {
    var response = await http.get(
        Uri.parse('http://madhack.codingblinders.com/job/65edfa92e4761f65ec8f2135'));
    if (response.statusCode == 200) {
      setState(() {
        jobData = jsonDecode(response.body)['data'];

      });
    } else {
      toastification.show(
        context: context,
        title: Text(jsonDecode(response.body)['message']),
        autoCloseDuration: const Duration(seconds: 2),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.bottomCenter,
        direction: TextDirection.ltr,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
        closeOnClick: false,
        pauseOnHover: false,
        dragToClose: true,
        applyBlurEffect: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove the title
        title: SizedBox.shrink(),
        // Add a back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Your description here
                  jobData == null
                      ? Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(jobData!['employer']['image']),
                              radius: 30.0,),

                            SizedBox(width: 20.0),
                            Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 270,
                                  child: Text(jobData!['title'] ,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black87,height: 0),),
                                ),
                                Container(
                                  width: 270,
                                  child: Text(jobData!['employer']['profile']['companyName']+ ' - ' + jobData!['location'],style: TextStyle(color: Colors.black54),),
                                ),
                                      ],
                            ),
                          ],

                        ),
                        SizedBox(height: 20.0),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text('${(jobData!['salaryRange']['low']/1000).toStringAsFixed(1)}K - ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                             Text('${(jobData!['salaryRange']['high']/1000).toStringAsFixed(1)}K ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                             Text('${jobData!['salaryRange']['currency']}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black54),),
                             Text('/Mon',style: TextStyle(fontSize: 17,color: Colors.black38),),

                           ],
                         ),
                        SizedBox(height: 16.0),
                        Text('Job Description',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
                        Text(jobData!['description']),
                        SizedBox(height: 16.0),
                        Text('Requirements:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
                        SizedBox(height: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: jobData!['requirements'].map<Widget>((req) => Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                              width: MediaQuery.of(context).size.width-20,
                              child: Text('⦿  $req'))).toList(),
                        ),
                        SizedBox(height: 10.0),
                        Text('Responsibilities:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
                        SizedBox(height: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: jobData!['responsibilities'].map<Widget>((resp) =>Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                              width: MediaQuery.of(context).size.width-20,
                              child: Text('⦿  $resp'))).toList(),

                        ),
                        SizedBox(height: 16.0),

                      ],
                    ),
                  ),







                ],
              ),
            ),
          ),
          // Bottom white bar with save icon and apply now button
          Container(
            height: 75.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black87,
                  ),
                  child: IconButton.filled(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      //i need shape square
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    ),

                    icon: Icon(Icons.bookmark,color: Colors.white,),
                    onPressed: () {
                      toastification.show(
                        context: context,
                        title: Text('Saved Sucessfully', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                        autoCloseDuration: const Duration(seconds: 3),
                        type: ToastificationType.success,
                        style: ToastificationStyle.flatColored,
                        alignment: Alignment.topRight,
                        direction: TextDirection.ltr,
                        showProgressBar: false,
                        closeButtonShowType: CloseButtonShowType.none,
                        closeOnClick: false,
                        pauseOnHover: true,
                        dragToClose: true,
                        applyBlurEffect: true,
                      );
                    },

                  ),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _showFormPopup(context,jobData!['_id']);
                  },

                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250.0, 55.0),
                    backgroundColor: Colors.grey,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Apply Now' ,style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showFormPopup(BuildContext context,String jobId) {
    final url = TextEditingController();
    final des = TextEditingController();

    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,

          title: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: Text("Enter Application Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 30,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                ),
                child: TextFormField(
                  controller: url,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Resume Url',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 163, 163, 163),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



                  ),
                ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: des,
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 163, 163),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding
                    ),
                  ),
                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                final String resume = url.text;
                final String description = des.text;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String userToken = prefs.getString('userToken') ?? '';
                String userId = prefs.getString('userId') ?? '';
                var headers = {
                  'x-access-token': userToken,
                  'Content-Type': 'application/json'
                };
                var request = http.Request('POST', Uri.parse('http://madhack.codingblinders.com/application/create'));
                request.body = json.encode({
                  "job": jobId,
                  "applicant": userId,
                  "resume": resume,
                  "description": description,
                  "status": "pending"
                });
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {

                  toastification.show(
                    context: context,
                    title: Text('Successfully Created!',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                    autoCloseDuration: const Duration(seconds: 3),
                    type: ToastificationType.success,
                    style: ToastificationStyle.fillColored,
                    alignment: Alignment.topCenter,
                    direction: TextDirection.ltr,
                    showProgressBar: false,
                    closeButtonShowType: CloseButtonShowType.none,
                    closeOnClick: false,
                    pauseOnHover: true,
                    dragToClose: true,
                    applyBlurEffect: true,
                  );
                  Navigator.of(context).pop();
                }
                else {
                  final cont =await response.stream.bytesToString();
                  final data = json.decode(cont);
                  toastification.show(
                    context: context,
                    title: Text(data['message'],style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                    autoCloseDuration: const Duration(seconds: 3),
                    type: ToastificationType.error,
                    style: ToastificationStyle.fillColored,
                    alignment: Alignment.topRight,
                    direction: TextDirection.ltr,
                    showProgressBar: false,
                    closeButtonShowType: CloseButtonShowType.none,
                    closeOnClick: false,
                    pauseOnHover: true,
                    dragToClose: true,
                    applyBlurEffect: true,
                  );
                // print(response.reasonPhrase);
                }


              },
            ),
          ],
        );
      },
    );
  }
}


