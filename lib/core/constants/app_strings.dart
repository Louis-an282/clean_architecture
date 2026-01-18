/// Application Text Constants and Localization Support
/// 
/// This file centralizes all user-facing text strings used throughout the
/// application. It serves as a foundation for internationalization (i18n)
/// and ensures consistent messaging across the app.
/// 
/// Organization strategy:
/// - Group strings by functionality (general actions, validation, auth, etc.)
/// - Use descriptive constant names that indicate usage context
/// - Include both labels and error messages
/// - Support for success/failure message pairs
/// 
/// Benefits:
/// - Easy text updates without searching through code
/// - Foundation for localization/translation
/// - Consistent messaging across the app
/// - Prevents typos in repeated strings
/// 
/// How to add new strings:
/// 1. Group new strings with related functionality
/// 2. Use descriptive names (include context like "Label", "Error", "Success")
/// 3. Keep strings concise but clear
/// 4. Add both positive and negative variations when applicable
/// 
/// Example of adding new feature strings:
/// ```dart
/// // Shopping cart feature
/// static const String addToCart = 'Add to Cart';
/// static const String removeFromCart = 'Remove from Cart';
/// static const String emptyCart = 'Your cart is empty';
/// static const String cartTotal = 'Total';
/// static const String checkout = 'Checkout';
/// 
/// // Payment feature
/// static const String paymentMethod = 'Payment Method';
/// static const String paymentSuccess = 'Payment completed successfully';
/// static const String paymentFailed = 'Payment failed. Please try again';
/// static const String invalidCardNumber = 'Please enter a valid card number';
/// ```
/// 
/// Future i18n integration:
/// ```dart
/// // This can be easily replaced with localization:
/// Text(AppLocalizations.of(context).login) // instead of AppStrings.login
/// ```

class AppStrings {
  static const String appTitle = 'Clean Architecture Demo';
  
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String update = 'Update';
  static const String search = 'Search';
  static const String refresh = 'Refresh';
  
  static const String noDataFound = 'No data found';
  static const String noInternetConnection = 'No internet connection';
  static const String somethingWentWrong = 'Something went wrong';
  static const String tryAgain = 'Please try again';
  
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String nameLabel = 'Name';
  static const String phoneLabel = 'Phone Number';
  
  static const String emailValidationError = 'Please enter a valid email';
  static const String passwordValidationError = 'Password must be at least 6 characters';
  static const String confirmPasswordValidationError = 'Passwords do not match';
  static const String nameValidationError = 'Please enter your name';
  static const String phoneValidationError = 'Please enter a valid phone number';
  
  static const String login = 'Login';
  static const String register = 'Register';
  static const String logout = 'Logout';
  static const String forgotPassword = 'Forgot Password?';
  
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String about = 'About';
  
  static const String loginSuccess = 'Login successful';
  static const String loginFailed = 'Login failed';
  static const String registerSuccess = 'Registration successful';
  static const String registerFailed = 'Registration failed';
}