/// Home Screen (Presentation Layer)
/// 
/// This is the main dashboard screen of the application that displays
/// the primary content and serves as the entry point after authentication.
/// It demonstrates Clean Architecture patterns in the UI layer.
/// 
/// Key responsibilities:
/// - Display main application content (posts, user data, etc.)
/// - Handle user interactions and navigation
/// - Manage local UI state (scroll controllers, animations)
/// - Listen to BLoC states and update UI accordingly
/// - Implement pull-to-refresh and infinite scrolling
/// 
/// Architecture patterns demonstrated:
/// - BLoC pattern for state management
/// - Separation of UI concerns from business logic
/// - Widget composition with reusable components
/// - Event-driven UI updates
/// - Proper resource management (dispose controllers)
/// 
/// How to add new screen features:
/// 1. Add necessary BLoC listeners for new state changes
/// 2. Create reusable widgets for complex UI components
/// 3. Handle loading, success, and error states appropriately
/// 4. Implement proper navigation between screens
/// 5. Add pull-to-refresh or other user interactions
/// 
/// Example of adding new features:
/// ```dart
/// // Add notification feature
/// @override
/// void initState() {
///   super.initState();
///   // Existing initialization...
///   context.read<NotificationBloc>().add(LoadNotifications());
/// }
/// 
/// // Add notification listener
/// BlocListener<NotificationBloc, NotificationState>(
///   listener: (context, state) {
///     if (state is NotificationReceived) {
///       _showNotificationSnackBar(state.notification);
///     }
///   },
///   child: // existing UI
/// )
/// 
/// // Add search functionality
/// class _HomeScreenState extends State<HomeScreen> {
///   final TextEditingController _searchController = TextEditingController();
///   
///   void _onSearchChanged() {
///     final query = _searchController.text;
///     context.read<PostsBloc>().add(SearchPosts(query));
///   }
///   
///   @override
///   void dispose() {
///     _searchController.dispose();
///     // existing dispose...
///     super.dispose();
///   }
/// }
/// ```
/// 
/// Widget structure:
/// - AppBar with actions (logout, notifications)
/// - Body with BlocBuilder for state-based rendering
/// - Loading states with skeleton loaders
/// - Error states with retry functionality
/// - Success states with scrollable content
/// - FloatingActionButton for quick actions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/posts/posts_bloc.dart';
import '../../bloc/posts/posts_event.dart';
import '../../bloc/posts/posts_state.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/common/skeleton_loader.dart';
import '../posts/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<PostsBloc>().add(LoadPosts());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostsBloc>().add(LoadMorePosts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(LogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(AppStrings.home),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
            child: IconButton(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const PostCardSkeleton(),
            );
          }

          if (state is PostsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostsBloc>().add(LoadPosts());
                    },
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          if (state is PostsLoaded) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text(
                  AppStrings.noDataFound,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostsBloc>().add(LoadPosts());
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.posts.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.posts.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: LoadingWidget()),
                    );
                  }

                  final post = state.posts[index];
                  return PostCard(post: post);
                },
              ),
            );
          }

          if (state is PostsLoadingMore) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: LoadingWidget()),
                  );
                }

                final post = state.posts[index];
                return PostCard(post: post);
              },
            );
          }

          return const Center(child: LoadingWidget());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create-post');
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}