import 'package:flutter/material.dart';





class EducationalExperienceFormScreen extends StatefulWidget {
  @override
  _EducationalExperienceFormScreenState createState() => _EducationalExperienceFormScreenState();
}

class _EducationalExperienceFormScreenState extends State<EducationalExperienceFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _instituteController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _fieldOfStudyController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isCurrentPosition = false;

  @override
  void dispose() {
    _instituteController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Experience Form'),
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
                controller: _instituteController,
                label: 'Institute/School',
                placeholder: 'Enter institute or school name',
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _degreeController,
                label: 'Degree',
                placeholder: 'Enter your degree',
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _fieldOfStudyController,
                label: 'Field of Study',
                placeholder: 'Enter your field of study',
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextFormFieldWithLabel(
                      controller: _startDateController,
                      label: 'Start Date',
                      placeholder: 'DD/MM/YYYY',
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: TextFormFieldWithLabel(
                      controller: _endDateController,
                      label: 'End Date',
                      placeholder: 'DD/MM/YYYY',
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _isCurrentPosition,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentPosition = value!;
                      });
                    },
                  ),
                  Text('This is my current position'),
                ],
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _descriptionController,
                label: 'Description',
                placeholder: 'Enter description',
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, submit data
                    // You can implement your submission logic here
                  }
                },
                child: Text('Save'),
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
  final int? maxLines;

  TextFormFieldWithLabel({
    required this.controller,
    required this.label,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.maxLines,
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
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }
}