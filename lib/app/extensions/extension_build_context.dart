import 'package:flutter/material.dart';

extension ExtensionBuildContext on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void push(Widget secondPage) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => secondPage));
  }

  Future<DateTime?> showMyDatePicker() async {
    return await showDatePicker(
        context: this,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
  }

  Future<TimeOfDay?> showMyTimePicker() async {
    return await showTimePicker(context: this, initialTime: TimeOfDay.now());
  }
}
