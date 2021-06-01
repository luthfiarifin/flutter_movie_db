import 'package:intl/intl.dart';

class Util {

  static const W500_IMAGE = 'https://image.tmdb.org/t/p/w500';
  static const ORIGINAL_IMAGE = 'https://image.tmdb.org/t/p/original';

  static String formatDate(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('MMM dd, yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}