import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';

class MyText extends StatelessWidget {
  const MyText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style ?? TextStyle(fontSize: 20),
    );
  }
}
