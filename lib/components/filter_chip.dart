import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  final String title;
  const FilterChipWidget({
    super.key,
    required this.title,
  });
  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.title),
      selected: isSelected,
      onSelected: (bool value) {
        setState(() {
          isSelected = !isSelected;
        });
      },
    );
  }
}
