import 'package:flutter/material.dart';




class WorkExperienceFormScreen extends StatefulWidget {
  @override
  _WorkExperienceFormScreenState createState() => _WorkExperienceFormScreenState();
}

class _WorkExperienceFormScreenState extends State<WorkExperienceFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isCurrentPosition = false;

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Work Experience'),
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
                controller: _jobTitleController,
                label: 'Job Title',
                placeholder: 'Enter your job title',
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _companyController,
                label: 'Company',
                placeholder: 'Enter company name',
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextFormFieldWithLabel(
                      controller: _startDateController,
                      label: 'Start Date',
                      placeholder: 'MM/YYYY',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: TextFormFieldWithLabel(
                      controller: _endDateController,
                      label: 'End Date',
                      placeholder: 'MM/YYYY',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isCurrentPosition,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentPosition = value ?? false;
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
                placeholder: 'Enter job description',
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, save data
                    // You can implement your save logic here
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
  final int? maxLines;

  TextFormFieldWithLabel({
    required this.controller,
    required this.label,
    required this.placeholder,
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