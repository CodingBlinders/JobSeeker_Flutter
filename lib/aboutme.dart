import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class AboutMeFormPage extends StatefulWidget {
  const AboutMeFormPage({super.key});

  @override
  State<AboutMeFormPage> createState() => _AboutMeFormPageState();
}

class _AboutMeFormPageState extends State<AboutMeFormPage> {
  Map<String, dynamic>? jobData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  List<TextEditingController> _linkControllers = [TextEditingController()];

  String _selectedCountryCode = '+1'; // Default country code

  void _addLinkField() {
    setState(() {
      _linkControllers.add(TextEditingController());
    });
  }

  Future<void> updateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    String userToken = prefs.getString('userToken') ?? '';

    var headers = {
      'x-access-token': userToken,
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'PATCH',
        Uri.parse(
            'http://madhack.codingblinders.com/users/update/$userId'));
    request.headers.addAll(headers);
    request.body = json.encode({
      "name": _fullNameController.text,
      "dob": _dobController.text,
      "contact": _phoneNumberController.text,
      "socialLinks": _linkControllers.map((controller) => controller.text).toList(),

    });
    print(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }



  void _removeLinkField(int index) {
    setState(() {
      _linkControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _linkControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me Form'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormFieldWithLabel(
                controller: _fullNameController,
                label: 'Full Name',
                placeholder: 'Enter your full name',
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _dobController,
                label: 'Date of Birth',
                placeholder: 'Enter your date of birth',
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _emailController,
                label: 'Email',
                placeholder: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormFieldWithLabel(
                      controller: TextEditingController(text: _selectedCountryCode),
                      label: '',
                      placeholder: '',
                      // enabled: false,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: TextFormFieldWithLabel(
                      controller: _phoneNumberController,
                      label: 'Phone Number',
                      placeholder: 'Enter your phone number',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  _linkControllers.length,
                      (index) => Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _linkControllers[index],

                          decoration: InputDecoration(
                            labelText: 'Link ${index + 1}',
                            hintText: 'Enter a link',
                            border: OutlineInputBorder(),
                            suffixIcon: _linkControllers.length > 1
                                ? IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _removeLinkField(index),
                            )
                                : null,
                          ),
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addLinkField,
                      icon: Icon(Icons.add),
                      label: Text('Add Link'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateUser();
                  }
                },
                child: Text('Submit'),


              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldWithLabel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool enabled;

  TextFormFieldWithLabel({
    required this.controller,
    required this.label,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(),
            suffixIcon: suffixIcon,
          ),
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
          enabled: enabled,
        ),
      ],
    );
  }
}
