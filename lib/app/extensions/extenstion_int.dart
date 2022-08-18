extension ExtensionInt on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
  }
}
