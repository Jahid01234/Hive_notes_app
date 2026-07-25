import 'package:intl/intl.dart';

class DateUtilHelper {
  DateUtilHelper._();

  static String formatFull(DateTime date) {
    return DateFormat('MMMM dd, yyyy • hh:mm a').format(date);
  }

  static String formatShort(DateTime date) {
    return DateFormat('MMM dd, hh:mm a').format(date);
  }

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM dd, yyyy').format(date);
  }
}