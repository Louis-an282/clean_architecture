/// Date and Time Utility Functions
/// 
/// This helper class provides various date and time formatting utilities
/// without external dependencies. It offers simple, commonly-used date
/// operations for UI display and data processing.
/// 
/// Available utilities:
/// - Basic date/time formatting (DD/MM/YYYY, HH:mm)
/// - Relative time displays ("2 hours ago", "Yesterday")
/// - Date comparison utilities (isToday, isYesterday)
/// - Time difference calculations
/// 
/// Design principles:
/// - No external dependencies (no intl package)
/// - Simple, readable formats suitable for most use cases
/// - Backward compatibility with legacy method names
/// - Localization-ready (can be easily replaced with intl)
/// 
/// How to add new date utilities:
/// 1. Add static methods that accept DateTime parameters
/// 2. Return formatted strings or boolean comparisons
/// 3. Handle edge cases (null dates, future dates, etc.)
/// 4. Consider localization needs for future updates
/// 
/// Example of adding new utilities:
/// ```dart
/// static String formatDateRange(DateTime start, DateTime end) {
///   if (isSameDay(start, end)) {
///     return formatDate(start);
///   }
///   return '${formatDate(start)} - ${formatDate(end)}';
/// }
/// 
/// static bool isSameWeek(DateTime date1, DateTime date2) {
///   final diff = date1.difference(date2).inDays.abs();
///   return diff < 7 && date1.weekday >= date2.weekday;
/// }
/// 
/// static String formatDuration(Duration duration) {
///   final hours = duration.inHours;
///   final minutes = duration.inMinutes % 60;
///   return '${hours}h ${minutes}m';
/// }
/// 
/// static DateTime startOfDay(DateTime date) {
///   return DateTime(date.year, date.month, date.day);
/// }
/// ```
/// 
/// Usage examples:
/// ```dart
/// final now = DateTime.now();
/// final formatted = DateHelper.formatDateTime(now); // "15/03/2024 14:30"
/// final relative = DateHelper.timeAgo(now.subtract(Duration(hours: 2))); // "2 hours ago"
/// final isToday = DateHelper.isToday(now); // true
/// ```

class DateHelper {
  // Simple date formatting without intl package
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${formatTime(date)}';
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

  // Alias for backward compatibility
  static String getTimeAgo(DateTime date) => timeAgo(date);

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }

  static String relativeDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      return formatDate(date);
    }
  }
}