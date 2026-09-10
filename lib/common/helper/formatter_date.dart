import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toReadableString() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
