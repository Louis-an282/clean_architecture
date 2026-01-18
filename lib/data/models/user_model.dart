/// User Data Model (Data Layer)
/// 
/// This model class extends UserEntity from the domain layer and adds
/// data serialization capabilities. Models are responsible for converting
/// between domain entities and external data formats (JSON, XML, etc.).
/// 
/// Key responsibilities:
/// - JSON serialization and deserialization
/// - Data transformation between API and domain formats
/// - Type-safe parsing with proper error handling
/// - Providing copyWith functionality for immutable updates
/// - Extending domain entity while adding data layer concerns
/// 
/// Architecture pattern:
/// - Extends domain entity (preserves business logic isolation)
/// - Adds fromJson/toJson for API communication
/// - Handles data format inconsistencies from backend
/// - Provides copyWith for state management
/// 
/// How to add new model classes:
/// 1. Create a class that extends the corresponding domain entity
/// 2. Add fromJson factory constructor for API response parsing
/// 3. Add toJson method for API request serialization
/// 4. Implement copyWith method for immutable updates
/// 5. Handle nullable fields and provide defaults
/// 6. Add proper type casting and error handling
/// 
/// Example of creating a new model:
/// ```dart
/// class PostModel extends PostEntity {
///   const PostModel({
///     required super.id,
///     required super.title,
///     required super.content,
///     required super.authorId,
///     required super.createdAt,
///     super.updatedAt,
///     required super.tags,
///     required super.isPublished,
///   });
/// 
///   factory PostModel.fromJson(Map<String, dynamic> json) {
///     return PostModel(
///       id: json['id'] as String,
///       title: json['title'] as String,
///       content: json['content'] as String,
///       authorId: json['author_id'] as String,
///       createdAt: DateTime.parse(json['created_at'] as String),
///       updatedAt: json['updated_at'] != null 
///         ? DateTime.parse(json['updated_at'] as String) 
///         : null,
///       tags: List<String>.from(json['tags'] as List),
///       isPublished: json['is_published'] as bool? ?? false,
///     );
///   }
/// 
///   Map<String, dynamic> toJson() {
///     return {
///       'id': id,
///       'title': title,
///       'content': content,
///       'author_id': authorId,
///       'created_at': createdAt.toIso8601String(),
///       'updated_at': updatedAt?.toIso8601String(),
///       'tags': tags,
///       'is_published': isPublished,
///     };
///   }
/// 
///   PostModel copyWith({
///     String? id,
///     String? title,
///     String? content,
///     // ... other parameters
///   }) {
///     return PostModel(
///       id: id ?? this.id,
///       title: title ?? this.title,
///       // ... other assignments
///     );
///   }
/// }
/// ```
/// 
/// Usage patterns:
/// ```dart
/// // From API response
/// final user = UserModel.fromJson(apiResponse);
/// 
/// // To API request
/// final json = user.toJson();
/// 
/// // Immutable updates
/// final updatedUser = user.copyWith(name: 'New Name');
/// ```

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.avatar,
    required super.createdAt,
    required super.updatedAt,
    required super.isVerified,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isVerified: json['is_verified'] as bool? ?? false,
      role: json['role'] as String? ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_verified': isVerified,
      'role': role,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVerified,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
    );
  }
}