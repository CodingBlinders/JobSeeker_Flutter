import 'package:flutter/material.dart';



class QualificationsFormScreen extends StatefulWidget {
  @override
  _WorkExperienceFormScreenState createState() => _WorkExperienceFormScreenState();
}

class _WorkExperienceFormScreenState extends State<QualificationsFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _QualificationController = TextEditingController();
  TextEditingController _DateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isCurrentPosition = false;

  @override
  void dispose() {
    _QualificationController.dispose();
    _DateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Qualification'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormFieldWithLabel(
                controller: _QualificationController,
                label: 'Qualification',
                placeholder: 'Enter your Qualification',
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextFormFieldWithLabel(
                      controller: _DateController,
                      label: 'Date',
                      placeholder: 'MM/YYYY',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormFieldWithLabel(
                controller: _descriptionController,
                label: 'Description',
                placeholder: 'Enter Qualification description',
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