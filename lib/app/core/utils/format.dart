
import 'package:intl/intl.dart';

class Format {

  static String money(int money) {
    return NumberFormat.simpleCurrency(locale: "fr_FR", decimalDigits: 0, name: "XOF").format(money);
  }


  static String date(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm').format(date);
  }

  static String image(String? image) {
    return image ?? "https://cdn-icons-png.flaticon.com/512/813/813728.png";
  }

  static String state(String? status) {
    switch(status) {
      case "pending":
      case "on-hold":
        return "En attente";
      case "processing":
        return "En cours";
      case "completed":
        return "Terminée";
      case "cancelled":
        return "Annulée";
      case "refunded":
        return "Remboursée";
      case "failed":
        return "Echouée";
      case "trash":
        return "Brouillon";
      default:
        return status ?? "";
    }
  }

}