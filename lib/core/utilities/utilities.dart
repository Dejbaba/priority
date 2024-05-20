
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utilities{

  static List<String> reviewerPics = [
    'assets/images/reviewer_image/reviewer_1.png',
    'assets/images/reviewer_image/reviewer_2.png',
    'assets/images/reviewer_image/reviewer_3.png',
    'assets/images/reviewer_image/reviewer_4.png',
    'assets/images/reviewer_image/reviewer_5.png',

  ];

  ///format currency
  static String formatAmount({double? amount, bool addDecimal = true}) {
    try{
      final oCcy = addDecimal
          ? NumberFormat('#,##0.00', 'en_US')
          : NumberFormat('#,##0', 'en_US');
      final formattedAmount = oCcy.format(amount);
      return formattedAmount;
    }catch(e){
      final oCcy = addDecimal
          ? NumberFormat('#,##0.00', 'en_US')
          : NumberFormat('#,##0', 'en_US');
      final formattedAmount = oCcy.format(0);
      return formattedAmount;
    }

  }

  ///returns date format
  static String actualDay(DateTime date) {
    date = new DateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").parseUTC(date.toString()).toLocal();
    String returnDate;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    //final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = date;
    final aDate =
    DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      returnDate = "Today";
    } else if (aDate == yesterday) {
      returnDate = "Yesterday";
    } else {
      returnDate =
      "${DateFormat.MMM().format(date)} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)}";
    }

    return returnDate;
  }

  ///formats input
  static String splitAndFormatInput({required String input, bool splitRating = false}){
    if(splitRating){
      final _splitRating = input.split('.');
      if(_splitRating.isEmpty){
        return input;
      }
      return _splitRating[0];
    }

    final _split = input.split(' ');
    return _split[0];
  }

  ///generates ID
  static String generateId(){
    var uuid = Uuid();
    final _id = uuid.v4();
    return _id;
  }


}