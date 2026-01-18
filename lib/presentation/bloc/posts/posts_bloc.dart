import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post_entity.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  
  PostsBloc() : super(const PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<RefreshPosts>(_onRefreshPosts);
  }

  Future<void> _onLoadPosts(
    LoadPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(const PostsLoading());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock data
    final posts = [
      PostEntity(
        id: '1',
        title: 'Clean Architecture in Flutter',
        content: 'This is a comprehensive guide to implementing clean architecture in Flutter applications with BLoC pattern.',
        authorId: '1',
        authorName: 'John Doe',
        tags: ['flutter', 'clean-architecture', 'bloc'],
        likesCount: 42,
        commentsCount: 8,
        isLiked: false,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: 'published',
      ),
      PostEntity(
        id: '2',
        title: 'State Management Best Practices',
        content: 'Learn about different state management solutions and when to use each one in your Flutter projects.',
        authorId: '2',
        authorName: 'Jane Smith',
        tags: ['flutter', 'state-management', 'best-practices'],
        likesCount: 31,
        commentsCount: 5,
        isLiked: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        status: 'published',
      ),
      PostEntity(
        id: '3',
        title: 'Widget Testing in Flutter',
        content: 'Complete guide to testing your Flutter widgets and ensuring app quality.',
        authorId: '1',
        authorName: 'John Doe',
        tags: ['flutter', 'testing', 'widgets'],
        likesCount: 25,
        commentsCount: 3,
        isLiked: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'published',
      ),
    ];

    emit(PostsLoaded(
      posts: posts,
      hasReachedMax: true,
      currentPage: 1,
    ));
  }

  Future<void> _onLoadMorePosts(
    LoadMorePosts event,
    Emitter<PostsState> emit,
  ) async {
    if (state is PostsLoaded) {
      final currentState = state as PostsLoaded;
      
      if (currentState.hasReachedMax) return;

      emit(PostsLoadingMore(posts: currentState.posts));

      // Simulate loading more posts
      await Future.delayed(const Duration(seconds: 1));

      final newPosts = [
        PostEntity(
          id: '${currentState.posts.length + 1}',
          title: 'Additional Post ${currentState.posts.length + 1}',
          content: 'This is an additional post loaded from pagination.',
          authorId: '1',
          authorName: 'John Doe',
          tags: ['flutter', 'pagination'],
          likesCount: 10,
          commentsCount: 2,
          isLiked: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: 'published',
        ),
      ];

      final allPosts = List<PostEntity>.from(currentState.posts)..addAll(newPosts);
      
      emit(PostsLoaded(
        posts: allPosts,
        hasReachedMax: allPosts.length >= 10, // Mock limit
        currentPage: currentState.currentPage + 1,
      ));
    }
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<PostsState> emit,
  ) async {
    add(const LoadPosts());
  }
}