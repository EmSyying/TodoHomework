import 'package:intl/intl.dart';

formatDate(String? datetime, String format) {
  final timezone = DateFormat('yyyy-MM-dd HH:mm').parse(datetime!);
  var strDateTime = DateFormat(format).format(timezone);
  return strDateTime;
}

formatDay(String? datetime, String format) {
  final timezone = DateFormat('yyyy-MM-dd').parse(datetime!);
  var strDateTime = DateFormat(format).format(timezone);
  return strDateTime;
}
