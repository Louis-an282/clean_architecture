/// Post Data Model (Data Layer)
/// 
/// This model extends PostEntity from the domain layer and adds JSON
/// serialization capabilities for API communication. It follows the same
/// pattern as UserModel with comprehensive data handling.
/// 
/// Key features:
/// - JSON serialization/deserialization
/// - Extends domain entity for Clean Architecture compliance
/// - Type-safe parsing with proper error handling
/// - Immutable data structure with copyWith support
/// - Handles complex data types (lists, optional fields)
/// 
/// Model responsibilities:
/// - Convert API JSON responses to domain entities
/// - Serialize domain entities for API requests
/// - Handle data transformations and mappings
/// - Provide default values for optional/missing fields
/// - Support immutable updates via copyWith
/// 
/// How to extend similar models:
/// 1. Extend the corresponding domain entity
/// 2. Implement fromJson with proper type casting and null handling
/// 3. Implement toJson for API requests
/// 4. Add copyWith method for immutable updates
/// 5. Handle collections and optional fields appropriately
/// 
/// Example usage:
/// ```dart
/// final post = PostModel.fromJson(apiResponse);
/// final json = post.toJson();
/// final updatedPost = post.copyWith(title: 'New Title', likesCount: 10);
/// ```

import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.authorId,
    required super.authorName,
    super.authorAvatar,
    required super.tags,
    required super.likesCount,
    required super.commentsCount,
    required super.isLiked,
    required super.createdAt,
    required super.updatedAt,
    super.images,
    required super.status,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorId: json['author_id'] as String,
      authorName: json['author_name'] as String,
      authorAvatar: json['author_avatar'] as String?,
      tags: List<String>.from(json['tags'] as List? ?? []),
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      isLiked: json['is_liked'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      images: json['images'] != null ? List<String>.from(json['images'] as List) : null,
      status: json['status'] as String? ?? 'published',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author_id': authorId,
      'author_name': authorName,
      'author_avatar': authorAvatar,
      'tags': tags,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'is_liked': isLiked,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'images': images,
      'status': status,
    };
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    List<String>? tags,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? images,
    String? status,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      tags: tags ?? this.tags,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      status: status ?? this.status,
    );
  }
}