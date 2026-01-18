/// String Extension Methods for Enhanced String Manipulation
/// 
/// This file provides a comprehensive set of string extension methods that
/// add useful functionality to Dart's built-in String class. These extensions
/// cover common string operations used throughout the application.
/// 
/// Extension categories:
/// - Text formatting (capitalize, case conversions)
/// - Validation (email, phone, numeric checks)
/// - Text processing (truncate, slugify, HTML cleaning)
/// - Masking and privacy (email/phone masking)
/// - Conversion utilities (date parsing, color hex)
/// - Utility functions (initials, word count, palindrome check)
/// 
/// Benefits:
/// - Cleaner, more readable code with method chaining
/// - Centralized string utilities
/// - Type-safe operations with proper null handling
/// - Consistent formatting across the application
/// 
/// How to add new string extensions:
/// 1. Add methods to the StringExtensions extension class
/// 2. Use descriptive names that clearly indicate functionality
/// 3. Handle edge cases (empty strings, null values)
/// 4. Return appropriate types (String, bool, or nullable types)
/// 5. Add corresponding methods to StringNullableExtensions if needed
/// 
/// Example of adding new extensions:
/// ```dart
/// extension StringExtensions on String {
///   // URL validation
///   bool get isValidUrl {
///     return Uri.tryParse(this) != null && 
///            (startsWith('http://') || startsWith('https://'));
///   }
///   
///   // Extract domain from email
///   String get emailDomain {
///     if (!isValidEmail) return '';
///     return split('@').last;
///   }
///   
///   // Convert to title case
///   String get toTitleCase {
///     return split(' ')
///         .map((word) => word.capitalizeFirst.toLowerCase())
///         .map((word) => word.capitalizeFirst)
///         .join(' ');
///   }
///   
///   // Remove diacritics/accents
///   String get removeDiacritics {
///     return replaceAll(RegExp(r'[àáâãäå]'), 'a')
///         .replaceAll(RegExp(r'[èéêë]'), 'e')
///         .replaceAll(RegExp(r'[ìíîï]'), 'i')
///         .replaceAll(RegExp(r'[òóôõö]'), 'o')
///         .replaceAll(RegExp(r'[ùúûü]'), 'u');
///   }
/// }
/// ```
/// 
/// Usage examples:
/// ```dart
/// final name = "john doe";
/// print(name.capitalizeWords); // "John Doe"
/// 
/// final email = "user@example.com";
/// print(email.isValidEmail); // true
/// print(email.maskEmail()); // "u***r@example.com"
/// 
/// final text = "Hello World!";
/// print(text.initials); // "HW"
/// print(text.slugify); // "hello-world"
/// ```

extension StringExtensions on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.capitalizeFirst)
        .join(' ');
  }

  String get removeSpaces => replaceAll(' ', '');

  String get removeSpecialCharacters => replaceAll(RegExp(r'[^\w\s]'), '');

  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'^[\+]?[1-9][\d]{0,15}$').hasMatch(replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  bool get isInteger {
    return int.tryParse(this) != null;
  }

  String get initials {
    if (isEmpty) return '';
    
    final words = trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
  }

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  String get slugify {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[-\s]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }

  String removeHtmlTags() {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  String get reversed => split('').reversed.join('');

  int get wordCount => trim().isEmpty ? 0 : trim().split(RegExp(r'\s+')).length;

  bool get isPalindrome {
    final cleaned = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleaned == cleaned.split('').reversed.join('');
  }

  String maskEmail() {
    if (!isValidEmail) return this;
    
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) {
      return '${username[0]}${'*' * (username.length - 1)}@$domain';
    } else {
      return '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}@$domain';
    }
  }

  String maskPhone() {
    if (length < 4) return this;
    
    final visibleDigits = 4;
    final maskedPart = '*' * (length - visibleDigits);
    return maskedPart + substring(length - visibleDigits);
  }

  String formatAsPhoneNumber() {
    final digits = replaceAll(RegExp(r'\D'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    
    return this;
  }

  // Note: Color conversion method removed due to import conflicts
  // Use parseColor() extension with proper Color import in calling files
  String? toColorHex() {
    String hexColor = this;
    
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }
    
    if (hexColor.length == 6 || hexColor.length == 8) {
      return '#$hexColor';
    }
    
    return null;
  }

  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }

  String toCamelCase() {
    return split(RegExp(r'[\s_-]+'))
        .map((word) => word.capitalizeFirst)
        .join('')
        .replaceRange(0, 1, this[0].toLowerCase());
  }

  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)?.toLowerCase()}',
    ).replaceAll(RegExp(r'^_'), '');
  }

  String toKebabCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '-${match.group(0)?.toLowerCase()}',
    ).replaceAll(RegExp(r'^-'), '');
  }
}

extension StringNullableExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  String orEmpty() => this ?? '';
  String orDefault(String defaultValue) => this ?? defaultValue;
}