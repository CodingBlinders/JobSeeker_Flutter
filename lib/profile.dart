import 'package:flutter/material.dart';


class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_pic.png'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to edit details page
                    },
                    label: Text('Edit Details'),
                    icon: Icon(Icons.edit),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                    )
                  )
                ],
              ),
            ),
            Container(
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileBarItem(
                    icon: Icons.person_outline_rounded,
                    title: 'About Me',
                    onPressed: () {
                      Navigator.pushNamed(context, '/aboutme');
                    },
                  ),
                  ProfileBarItem(
                    icon: Icons.work_outline_rounded,
                    title: 'Work Experience',
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-experience');
                    },
                  ),
                  ProfileBarItem(
                    icon: Icons.school_outlined,
                    title: 'Education',
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-education');
                    },
                  ),
                  ProfileBarItem(
                    icon: Icons.star,
                    title: 'Skill',
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-skill');
                    },
                  ),
                  ProfileBarItem(
                    icon: Icons.stars_outlined,
                    title: 'Qualification',
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-qualification');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ProfileBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const ProfileBarItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color.fromARGB(75, 177, 177, 177), blurRadius: 5, spreadRadius: 1)],
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.add_circle_outlined),
          ],
        ),
      ),
    );
  }
}
