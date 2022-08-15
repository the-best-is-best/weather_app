import 'package:flutter/material.dart';

import '../../presentation/weather/cubit/weather_cubit.dart';

class MyField extends StatelessWidget {
  const MyField({
    Key? key,
    required this.weatherCubit,
    required this.text,
    this.onTap,
    this.controller,
    this.onSubmitted,
  }) : super(key: key);
  final GestureTapCallback? onTap;
  final WeatherCubit weatherCubit;
  final String text;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      keyboardType: onTap != null ? TextInputType.none : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 6, left: 12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), gapPadding: 6),
        hintText: text,
      ),
      onSubmitted: onSubmitted,
    );
  }
}
