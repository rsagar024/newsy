import 'package:flutter/material.dart';

class NewsCategoryWidget extends StatelessWidget {
  final String title;
  final bool selected;
  const NewsCategoryWidget({super.key, required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border(
          bottom: selected ? BorderSide.none : const BorderSide(color: Color(0xFFB20909), width: 2),
          top: selected ? const BorderSide(color: Color(0xFFB20909), width: 2) : BorderSide.none,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
