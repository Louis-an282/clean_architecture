import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostsEvent {
  final int page;
  final int limit;
  final String? search;
  final List<String>? tags;
  final bool isRefresh;

  const LoadPosts({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.tags,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [page, limit, search, tags, isRefresh];
}

class LoadMorePosts extends PostsEvent {
  const LoadMorePosts();
}

class RefreshPosts extends PostsEvent {
  const RefreshPosts();
}

class SearchPosts extends PostsEvent {
  final String query;

  const SearchPosts({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterPostsByTags extends PostsEvent {
  final List<String> tags;

  const FilterPostsByTags({required this.tags});

  @override
  List<Object> get props => [tags];
}

class LikePost extends PostsEvent {
  final String postId;

  const LikePost({required this.postId});

  @override
  List<Object> get props => [postId];
}

class UnlikePost extends PostsEvent {
  final String postId;

  const UnlikePost({required this.postId});

  @override
  List<Object> get props => [postId];
}

class CreatePost extends PostsEvent {
  final String title;
  final String content;
  final List<String>? tags;
  final List<String>? images;

  const CreatePost({
    required this.title,
    required this.content,
    this.tags,
    this.images,
  });

  @override
  List<Object?> get props => [title, content, tags, images];
}

class UpdatePost extends PostsEvent {
  final String id;
  final String? title;
  final String? content;
  final List<String>? tags;
  final List<String>? images;

  const UpdatePost({
    required this.id,
    this.title,
    this.content,
    this.tags,
    this.images,
  });

  @override
  List<Object?> get props => [id, title, content, tags, images];
}

class DeletePost extends PostsEvent {
  final String postId;

  const DeletePost({required this.postId});

  @override
  List<Object> get props => [postId];
}