import 'package:lookea/models/payment_model.dart';

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
}

extension ParseToString on PaymentType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int year,
      int month,
      int day,
      int hour,
      int minute,
      int second,
      int millisecond,
      int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}