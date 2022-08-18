import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ExtensionBuildContext on BuildContext {
  AppLocalizations strings() {
    return AppLocalizations.of(this)!;
  }

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void back() {
    Navigator.pop(this);
  }

  void push(Widget secondPage) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => secondPage));
  }

  void showMyCountryPicker({required ValueChanged<Country> onSelect}) {
    showCountryPicker(
      context: this,
      onSelect: onSelect,
    );
  }
}
