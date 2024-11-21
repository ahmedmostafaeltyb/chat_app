import 'package:flutter/material.dart';

class SqureImage extends StatelessWidget {
  final String imagepath;
  const SqureImage({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.white)),
      child: Image.asset(
        imagepath,
        height: 40,
        width: 40,
      ),
    );
  }
}
