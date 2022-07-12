import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  const MyTextBox({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: Colors.blue.shade200,
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
