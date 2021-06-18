import 'package:intl/intl.dart';

Map<String, String> formatDateTime(DateTime toFormat){
  String time = DateFormat('HH:mm').format(toFormat);
  String date = DateFormat('dd/MMM').format(toFormat);
  return {'time': time, 'date': date};
}