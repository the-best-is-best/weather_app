extension ExtensionInt on int {
  DateTime toDateTime() {
    print(this);
    print(DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true));
    return DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
  }
}
