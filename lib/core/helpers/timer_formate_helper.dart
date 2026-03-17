import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// A utility class for formatting timestamps
class TimeFormatHelper {
  TimeFormatHelper._(); // Prevent instantiation

  /// Returns a day and date
  /// - Today
  /// - Yesterday
  /// - 12/03/2026
  static String formatMessageDate(Timestamp timestamp) {
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
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  /// Returns time With AM and PM.
  /// - 10:45 PM
  /// - 08:05 AM
  static String formatTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date);
  }

  /// Returns a full smart timestamp used in chat previews.
  /// - Today, 10:30 PM
  /// - Yesterday, 9:15 AM
  /// - 12/03/2026, 08:00 PM
  static String formatChatTimestamp(Timestamp timestamp) {
    final dateLabel = formatMessageDate(timestamp);
    final time = formatTime(timestamp);

    return "$dateLabel, $time";
  }

  /// Returns relative time for recent messages.
  /// - 'Just now', '5 min ago', '2 hr ago', '3 days ago' etc
  static String formatRelativeTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final now = DateTime.now();

    final diff = now.difference(date);

    if (diff.inSeconds < 10) {
      return 'Just now';
    } else if (diff.inMinutes < 1) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inDays < 1) {
      return '${diff.inHours} hr ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  /// Returns true if two timestamps fall on the same day.
  static bool isSameDay(Timestamp a, Timestamp b) {
    final d1 = a.toDate();
    final d2 = b.toDate();

    return d1.year == d2.year &&
        d1.month == d2.month &&
        d1.day == d2.day;
  }

  /// Returns true if the timestamp is from today.
  static bool isToday(Timestamp timestamp) {
    final now = DateTime.now();
    final date = timestamp.toDate();

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }


}