import 'package:syncfusion_flutter_charts/charts.dart';

extension ExtensionString on String {
  int toInt() {
    return int.tryParse(this) ?? 500;
  }
}
