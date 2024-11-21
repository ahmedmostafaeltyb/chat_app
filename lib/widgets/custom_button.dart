import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({this.ontab, required this.title});
  final String title;
  VoidCallback? ontab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.amber[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        )),
      ),
    );
  }
}
