import 'package:equatable/equatable.dart';
import '../../../domain/entities/post_entity.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoadingMore extends PostsState {
  final List<PostEntity> posts;

  const PostsLoadingMore({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsLoaded extends PostsState {
  final List<PostEntity> posts;
  final bool hasReachedMax;
  final int currentPage;

  const PostsLoaded({
    required this.posts,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [posts, hasReachedMax, currentPage];

  PostsLoaded copyWith({
    List<PostEntity>? posts,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return PostsLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class PostsError extends PostsState {
  final String message;

  const PostsError({required this.message});

  @override
  List<Object> get props => [message];
}

class PostLiked extends PostsState {
  final PostEntity post;

  const PostLiked({required this.post});

  @override
  List<Object> get props => [post];
}

class PostUnliked extends PostsState {
  final PostEntity post;

  const PostUnliked({required this.post});

  @override
  List<Object> get props => [post];
}

class PostLikeError extends PostsState {
  final String message;

  const PostLikeError({required this.message});

  @override
  List<Object> get props => [message];
}

class PostCreated extends PostsState {
  final PostEntity post;

  const PostCreated({required this.post});

  @override
  List<Object> get props => [post];
}

class PostUpdated extends PostsState {
  final PostEntity post;

  const PostUpdated({required this.post});

  @override
  List<Object> get props => [post];
}

class PostDeleted extends PostsState {
  final String postId;

  const PostDeleted({required this.postId});

  @override
  List<Object> get props => [postId];
}

class PostOperationError extends PostsState {
  final String message;

  const PostOperationError({required this.message});

  @override
  List<Object> get props => [message];
}