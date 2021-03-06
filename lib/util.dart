import 'package:intl/intl.dart';

class Util {
  static const WEB_MOVIE_URL = 'https://www.themoviedb.org/movie/';

  static const W500_IMAGE = 'https://image.tmdb.org/t/p/w500';
  static const ORIGINAL_IMAGE = 'https://image.tmdb.org/t/p/original';

  static String formatDate(String date, {String outputType = 'MMM dd, yyyy'}) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat(outputType);
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}
