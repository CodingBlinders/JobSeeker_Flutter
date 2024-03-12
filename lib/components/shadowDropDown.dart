import 'package:flutter/material.dart';

Widget decoratedDropdownButtonFormField({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add border
      borderRadius: BorderRadius.circular(5.0), // Add border radius
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 20,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: DropdownButtonFormField<String>(
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.transparent, // Set to transparent to let Container handle background color
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}