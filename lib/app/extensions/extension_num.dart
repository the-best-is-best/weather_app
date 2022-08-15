extension ExtensionDouble on num {
  //kelvin to celsius
  String kelvinToCelsius() {
    return "${(this - 273.15).toStringAsFixed(0)} \u00B0C";
  }
}
