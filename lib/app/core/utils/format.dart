
import 'package:intl/intl.dart';

class Format {

  static String money(int money) {
    return NumberFormat.simpleCurrency(locale: "fr_FR", decimalDigits: 0, name: "XOF").format(money);
  }


  static String date(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm').format(date);
  }

}