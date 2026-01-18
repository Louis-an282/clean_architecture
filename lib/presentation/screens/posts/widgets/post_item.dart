import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../../bloc/posts/posts_bloc.dart';
import '../../../bloc/posts/posts_event.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;

  const PostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultMargin,
        vertical: AppDimensions.smallMargin,
      ),
      color: AppColors.cardColor,
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimensions.smallPadding),
            _buildTitle(),
            const SizedBox(height: AppDimensions.smallPadding),
            _buildContent(),
            if (post.images != null && post.images!.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.smallPadding),
              _buildImages(),
            ],
            if (post.tags.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.smallPadding),
              _buildTags(),
            ],
            const SizedBox(height: AppDimensions.defaultPadding),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primaryLight,
          backgroundImage: post.authorAvatar != null 
              ? NetworkImage(post.authorAvatar!) 
              : null,
          child: post.authorAvatar == null
              ? Text(
                  post.authorName.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                )
              : null,
        ),
        const SizedBox(width: AppDimensions.smallPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.authorName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                DateHelper.getTimeAgo(post.createdAt),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Show more options
          },
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      post.title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildContent() {
    return Text(
      post.content,
      style: const TextStyle(
        color: AppColors.textPrimary,
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildImages() {
    if (post.images == null || post.images!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.images!.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: AppDimensions.smallMargin),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
              child: Image.network(
                post.images![index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primaryLight,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: AppDimensions.smallPadding,
      children: post.tags.map((tag) {
        return Chip(
          label: Text(
            tag,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.primaryLight,
          side: BorderSide.none,
        );
      }).toList(),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        _buildActionButton(
          icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
          label: post.likesCount.toString(),
          color: post.isLiked ? AppColors.errorColor : AppColors.textSecondary,
          onPressed: (context) {
            if (post.isLiked) {
              context.read<PostsBloc>().add(UnlikePost(postId: post.id));
            } else {
              context.read<PostsBloc>().add(LikePost(postId: post.id));
            }
          },
        ),
        const SizedBox(width: AppDimensions.defaultPadding),
        _buildActionButton(
          icon: Icons.comment,
          label: post.commentsCount.toString(),
          color: AppColors.textSecondary,
          onPressed: (context) {
            // TODO: Navigate to comments
          },
        ),
        const SizedBox(width: AppDimensions.defaultPadding),
        _buildActionButton(
          icon: Icons.share,
          label: 'Share',
          color: AppColors.textSecondary,
          onPressed: (context) {
            // TODO: Share post
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Function(BuildContext) onPressed,
  }) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => onPressed(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}