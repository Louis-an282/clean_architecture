import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final List<String> tags;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? images;
  final String status;

  const PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.tags,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
    this.images,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        authorId,
        authorName,
        authorAvatar,
        tags,
        likesCount,
        commentsCount,
        isLiked,
        createdAt,
        updatedAt,
        images,
        status,
      ];
}