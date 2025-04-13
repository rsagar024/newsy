import 'package:flutter/material.dart';

class MetadataItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;
  final EdgeInsetsGeometry padding;

  const MetadataItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    this.valueStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    this.padding = const EdgeInsets.only(top: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: '$label : ', style: labelStyle),
          TextSpan(text: value, style: valueStyle),
        ]),
      ),
    );
  }
}
