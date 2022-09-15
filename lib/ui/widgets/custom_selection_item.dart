import 'package:flutter/material.dart';

class CustomSelectionItem extends StatefulWidget {
  final Function onChangeCallback;
  final List<String> items;
  final String initValue;

  const CustomSelectionItem({
    Key? key,
    required this.onChangeCallback,
    required this.items,
    required this.initValue,
  }) : super(key: key);

  @override
  State<CustomSelectionItem> createState() => _CustomSelectionItemState();
}

class _CustomSelectionItemState extends State<CustomSelectionItem> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      value: widget.initValue,
      dropdownColor: Colors.grey[800],
      items: widget.items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.end,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        widget.onChangeCallback(newValue);
      },
    );
  }
}
