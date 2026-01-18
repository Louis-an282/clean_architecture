/// Local Storage Service (Data Layer)
/// 
/// This service provides a simplified interface for local data persistence
/// using SharedPreferences. It handles user tokens, user data, and other
/// application settings that need to persist across app sessions.
/// 
/// Key features:
/// - User authentication token management
/// - User profile data persistence
/// - Settings and preferences storage
/// - JSON serialization for complex objects
/// - Type-safe storage operations
/// 
/// Storage types supported:
/// - Strings, integers, booleans, doubles
/// - Complex objects via JSON encoding
/// - Lists and collections
/// 
/// How to add new storage methods:
/// 1. Add constants in AppConstants for storage keys
/// 2. Create getter/setter methods following the pattern
/// 3. Use appropriate SharedPreferences methods
/// 4. Handle JSON encoding/decoding for complex objects
/// 5. Add proper error handling
/// 
/// Example of adding new storage:
/// ```dart
/// // App settings
/// Future<void> saveThemeMode(String themeMode) async {
///   await _prefs.setString('theme_mode', themeMode);
/// }
/// 
/// Future<String> getThemeMode() async {
///   return _prefs.getString('theme_mode') ?? 'system';
/// }
/// 
/// // User preferences
/// Future<void> saveNotificationSettings(Map<String, bool> settings) async {
///   final jsonString = json.encode(settings);
///   await _prefs.setString('notification_settings', jsonString);
/// }
/// 
/// Future<Map<String, bool>> getNotificationSettings() async {
///   final jsonString = _prefs.getString('notification_settings');
///   if (jsonString != null) {
///     final decoded = json.decode(jsonString);
///     return Map<String, bool>.from(decoded);
///   }
///   return {'push': true, 'email': false, 'sms': false}; // defaults
/// }
/// 
/// // Recent searches
/// Future<void> addRecentSearch(String query) async {
///   final searches = await getRecentSearches();
///   searches.remove(query); // Remove if exists
///   searches.insert(0, query); // Add to beginning
///   if (searches.length > 10) searches.removeLast(); // Limit to 10
///   await _prefs.setStringList('recent_searches', searches);
/// }
/// 
/// Future<List<String>> getRecentSearches() async {
///   return _prefs.getStringList('recent_searches') ?? [];
/// }
/// ```

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class LocalStorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserToken(String token) async {
    await _prefs.setString(AppConstants.userTokenKey, token);
  }

  Future<String?> getUserToken() async {
    return _prefs.getString(AppConstants.userTokenKey);
  }

  Future<void> clearUserToken() async {
    await _prefs.remove(AppConstants.userTokenKey);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final jsonString = json.encode(userData);
    await _prefs.setString(AppConstants.userDataKey, jsonString);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final jsonString = _prefs.getString(AppConstants.userDataKey);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> clearUserData() async {
    await _prefs.remove(AppConstants.userDataKey);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  Future<void> saveObject(String key, Map<String, dynamic> object) async {
    final jsonString = json.encode(object);
    await _prefs.setString(key, jsonString);
  }

  Map<String, dynamic>? getObject(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> saveList(String key, List<Map<String, dynamic>> list) async {
    final jsonString = json.encode(list);
    await _prefs.setString(key, jsonString);
  }

  List<Map<String, dynamic>> getList(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      final List<dynamic> decodedList = json.decode(jsonString);
      return decodedList.cast<Map<String, dynamic>>();
    }
    return [];
  }
}