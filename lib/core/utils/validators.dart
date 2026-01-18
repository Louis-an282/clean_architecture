/// Form Input Validation Utilities
/// 
/// This class provides static validation methods for common form inputs.
/// All validators return either null (valid) or a String error message (invalid).
/// 
/// Available validators:
/// - Email validation with regex pattern
/// - Password validation with strength requirements
/// - And more can be added following the same pattern
/// 
/// How to add new validators:
/// 1. Create a static method that accepts String? and returns String?
/// 2. Return null if validation passes, error message if it fails
/// 3. Add a static getter for backward compatibility if needed
/// 4. Use appropriate regex patterns or validation logic
/// 
/// Example of adding a new validator:
/// ```dart
/// static String? validatePhoneNumber(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Phone number is required';
///   }
///   
///   final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
///   if (!phoneRegex.hasMatch(value)) {
///     return 'Please enter a valid phone number';
///   }
///   
///   return null;
/// }
/// 
/// // Add getter for easy access
/// static String? Function(String?) get phoneNumber => validatePhoneNumber;
/// ```
/// 
/// Usage in forms:
/// ```dart
/// TextFormField(
///   validator: Validators.email,
///   // or
///   validator: (value) => Validators.validateEmail(value),
/// )
/// ```

class Validators {
  // Static getters for backward compatibility
  static String? Function(String?) get email => validateEmail;
  static String? Function(String?) get password => validatePassword;
  
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^[\+]?[1-9][\d]{0,15}$');
    
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    return null;
  }

  static String? validateMinLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }
    
    return null;
  }

  static String? validateMaxLength(String? value, int maxLength, {String? fieldName}) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'This field'} must not exceed $maxLength characters';
    }
    
    return null;
  }

  static String? validateNumeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a number';
    }
    
    return null;
  }

  static String? validateInteger(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a whole number';
    }
    
    return null;
  }

  static String? validateUrl(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&=]*)$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    
    final age = int.tryParse(value);
    if (age == null) {
      return 'Age must be a number';
    }
    
    if (age < 0 || age > 150) {
      return 'Please enter a valid age';
    }
    
    return null;
  }

  static String? validateDateOfBirth(DateTime? value) {
    if (value == null) {
      return 'Date of birth is required';
    }
    
    final now = DateTime.now();
    final age = now.year - value.year;
    
    if (value.isAfter(now)) {
      return 'Date of birth cannot be in the future';
    }
    
    if (age > 150) {
      return 'Please enter a valid date of birth';
    }
    
    return null;
  }

  static String? combineValidators(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}