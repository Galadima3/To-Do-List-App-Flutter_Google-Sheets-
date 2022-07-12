import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;
  const MyButton({Key? key, this.text, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0, left: 8),
      child: GestureDetector(
        onTap: function,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.pink.shade500,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
