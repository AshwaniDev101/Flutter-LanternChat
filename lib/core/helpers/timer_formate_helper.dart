import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimerFormateHelper {
  static String formatMessageDate(Timestamp timestamp) {
    // Convert Firestore Timestamp → Dart DateTime (local time zone)
    final date = timestamp.toDate();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDay = DateTime(date.year, date.month, date.day);

    if (messageDay == today) {
      return 'Today';
    } else if (messageDay == yesterday) {
      return 'Yesterday';
    } else {
      // Format: 31/02/2026 → day/month/year with leading zeros
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(date);
    }
  }

  static String formatTimestampTime(Timestamp timestamp) {
    final date = timestamp.toDate();

    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final second = date.second.toString().padLeft(2, '0');

    final millisecond =
    (date.microsecond ~/ 1000).toString().padLeft(3, '0'); // convert micro → milli

    return "$hour:$minute:$second.$millisecond";
  }
}