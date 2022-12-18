import 'package:flutter/material.dart';

class TopBarItemView extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const TopBarItemView(
      {Key? key, required this.title, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
          IconButton(
              onPressed: () {
                if (int.parse(controller.text) > 0) {
                  controller.text = (int.parse(controller.text) - 1).toString();
                }
              },
              icon: Icon(Icons.remove)),
          SizedBox(
            width: 50,
            height: 30,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  enabled: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
          ),
          IconButton(
              onPressed: () {
                controller.text = (int.parse(controller.text) + 1).toString();
              },
              icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
