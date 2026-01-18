/// User Entity (Domain Layer)
/// 
/// This class represents the core User business object in the domain layer.
/// Entities are plain Dart classes that encapsulate business data and rules
/// without any external dependencies (no UI, database, or network concerns).
/// 
/// Key characteristics:
/// - Extends Equatable for easy comparison and testing
/// - Contains only business-relevant properties
/// - Immutable (all fields are final)
/// - No business logic methods (pure data)
/// - Independent of external frameworks or databases
/// 
/// How to add new entities:
/// 1. Create a new class extending Equatable
/// 2. Define all fields as final for immutability
/// 3. Add a const constructor with all required parameters
/// 4. Override props getter to include all fields for comparison
/// 5. Use appropriate nullable types (String?) for optional fields
/// 
/// Example of adding a new entity:
/// ```dart
/// class PostEntity extends Equatable {
///   final String id;
///   final String title;
///   final String content;
///   final String authorId;
///   final DateTime createdAt;
///   final DateTime? updatedAt;
///   final List<String> tags;
///   final bool isPublished;
/// 
///   const PostEntity({
///     required this.id,
///     required this.title,
///     required this.content,
///     required this.authorId,
///     required this.createdAt,
///     this.updatedAt,
///     required this.tags,
///     required this.isPublished,
///   });
/// 
///   @override
///   List<Object?> get props => [
///     id, title, content, authorId, createdAt, 
///     updatedAt, tags, isPublished,
///   ];
/// }
/// ```

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isVerified;
  final String role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.isVerified,
    required this.role,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        avatar,
        createdAt,
        updatedAt,
        isVerified,
        role,
      ];
}