import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../bloc/posts/posts_bloc.dart';
import '../../bloc/posts/posts_event.dart';
import '../../bloc/posts/posts_state.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/skeleton_loader.dart';
import 'widgets/post_card.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _setupScrollListener();
  }

  void _loadPosts() {
    context.read<PostsBloc>().add(LoadPosts());
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final postsBloc = context.read<PostsBloc>();
        final state = postsBloc.state;
        if (state is PostsLoaded) {
          postsBloc.add(LoadMorePosts());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Posts',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadPosts();
        },
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const ListSkeleton(
                itemCount: 5,
                skeletonItem: PostCardSkeleton(),
              );
            }

            if (state is PostsError) {
              return CustomErrorWidget(
                message: state.message,
                onRetry: _loadPosts,
              );
            }

            if (state is PostsLoaded) {
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingS,
                ),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  if (index == state.posts.length) {
                    return const Padding(
                      padding: EdgeInsets.all(AppDimensions.paddingM),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final post = state.posts[index];
                  return PostCard(
                    post: post,
                    onTap: () {
                      // Navigate to post detail
                    },
                    onLike: () {
                      // Handle like
                    },
                    onComment: () {
                      // Handle comment
                    },
                    onShare: () {
                      // Handle share
                    },
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create post
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}