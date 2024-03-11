import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  bool _isObscure = true; // Track whether the password is obscured or not

  Future<void> _signup() async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('http://127.0.0.1:4000/api/auth/signup'));
    request.bodyFields = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'confirm_password': _confirmPasswordController.text,
      'name': _nameController.text,
      'role': _roleController.text,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Create an Account',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Text(
                  'Email',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                _buildInputField(_emailController, 'user@mail.com'),
              ],
            ),
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
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
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '********',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 163, 163),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
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
                    controller: _confirmPasswordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '********',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 163, 163),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                _buildInputField(_nameController, 'Saman Kumara'),
              ],
            ),
            SizedBox(height: 10), // Add gap between input fields and labels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Role',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                _buildInputField(_roleController, 'Enter your role'),
              ],
            ),
            SizedBox(height: 30), // Add larger gap after last input field
            ElevatedButton(
              onPressed: _signup,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(223, 217, 217, 217), // Set button color to gray
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Set border radius
                ),
                minimumSize: Size(190, 50), // Set button size
              ),
              child: Text('Sign Up',style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold

              ),),
            ),
            SizedBox(height: 6.0,),
            Text('or Sign in with',style: TextStyle(
              color: Colors.grey
            ),),
            Row(

              mainAxisAlignment: MainAxisAlignment.center, // Adjust the spacing between buttons

              children: [
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.mail,
                  color: Colors.grey,),
                  iconSize: 24,),
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.facebook,
                  color: Colors.grey,),
                  iconSize: 24,),
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.apple,
                  color: Colors.grey,),
                  iconSize: 24,)
              ],
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: () {

              },
              child: Text(
                'Already a Member? Signup',
                              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return Container(
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
        controller: controller,
        obscureText: _isObscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 163, 163, 163),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), // Adjust padding



        ),
      ),
    );
  }
}

