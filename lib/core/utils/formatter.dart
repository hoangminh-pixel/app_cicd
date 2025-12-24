import 'package:intl/intl.dart';

class Formatter {
  static final formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );
}
