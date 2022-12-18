import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final Function onChange;
  final bool isChecked;

  const ListItem(
      {Key? key,
      required this.title,
      this.isChecked = false,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      const SizedBox(width: 8),
      Checkbox(
          value: isChecked,
          onChanged: (value) {
            onChange();
          })
    ]);
  }
}
