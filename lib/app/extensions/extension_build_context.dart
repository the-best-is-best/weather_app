import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

extension ExtensionBuildContext on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void back() {
    Navigator.pop(this);
  }

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

  void showMyCountryPicker({required ValueChanged<Country> onSelect}) {
    showCountryPicker(
      context: this,
      favorite: ['eg,us'],
      onSelect: onSelect,
    );
  }
}
