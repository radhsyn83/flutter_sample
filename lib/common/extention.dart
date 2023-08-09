import 'package:intl/intl.dart';

extension IntExtension on int {
  String toRupiah() {
    final oCcy = NumberFormat("#,##0", "en_US");
    return "Rp${oCcy.format(this).toString().replaceAll(",", ".")}";
  }

  String toCurrency() {
    final oCcy = NumberFormat("#,##0", "en_US");
    return oCcy.format(this).toString().replaceAll(",", ".");
  }
}
