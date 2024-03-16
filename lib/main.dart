import 'package:flutter/material.dart';
import 'package:jobseeker_madhack/JobPosting.dart';
import 'package:jobseeker_madhack/aboutme.dart';
import 'package:jobseeker_madhack/add_education.dart';
import 'package:jobseeker_madhack/add_experiance.dart';
import 'package:jobseeker_madhack/add_qualifications.dart';
import 'package:jobseeker_madhack/add_skill.dart';
import 'package:jobseeker_madhack/filter_screen.dart';
import 'package:jobseeker_madhack/home_screen.dart';
import 'package:jobseeker_madhack/job_view.dart';
import 'package:jobseeker_madhack/login.dart';
import 'package:jobseeker_madhack/profile.dart';
import 'package:jobseeker_madhack/send_cv.dart';
import 'package:jobseeker_madhack/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobSeeker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              displayLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/profile',
      routes: {
        '/login': (context) =>  LoginPage(),
        '/signup': (context) =>  SignupPage(),
        '/filter': (context) => const FilterScreen(),
        '/send-cv': (context) => const SendCVScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) =>  UserProfilePage(),
        '/aboutme': (context) =>  AboutMeFormPage(),
        '/add-education': (context) =>  EducationalExperienceFormScreen(),
        '/add-skill': (context) =>  AddSkillScreen(),
        '/add-experience': (context) =>  WorkExperienceFormScreen(),
        '/add-qualification': (context) =>  QualificationsFormScreen(),
        '/job-view': (context) =>  JobView(),
        '/emp': (context) =>  JobPosting(),
      },
    );
  }
}
