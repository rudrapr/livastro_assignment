import 'package:flutter/material.dart';

class BottomBarView extends StatelessWidget {
  final String message;
  final Function() onReset;

  const BottomBarView({Key? key, required this.message, required this.onReset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isError = message != 'Success';
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          TextButton(
            onPressed: onReset,
            style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                fixedSize: const Size(130, 70),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero))),
            child: const Text(
              'Reset all\nvalues to\n\'0\'',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 13),
            ),
          ),
          Expanded(
            child: Container(
              color: isError ? Colors.red : Colors.greenAccent.shade400,
              padding: const EdgeInsets.all(4),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: isError ? FontWeight.w400 : FontWeight.w600,
                      fontSize: isError ? 14 : 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
