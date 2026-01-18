import 'package:flutter/material.dart';
import '../../../core/constants/app_dimensions.dart';

class SkeletonLoader extends StatefulWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    Key? key,
    this.width,
    required this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
      ),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: const [
                Color(0xFFE0E0E0),
                Color(0xFFF5F5F5),
                Color(0xFFE0E0E0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingXS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SkeletonLoader(
                  height: 40,
                  width: 40,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLoader(
                        height: 14,
                        width: 100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 4),
                      SkeletonLoader(
                        height: 12,
                        width: 80,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingM),
            SkeletonLoader(
              height: 16,
              width: double.infinity,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            SkeletonLoader(
              height: 14,
              width: double.infinity,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            SkeletonLoader(
              height: 14,
              width: MediaQuery.of(context).size.width * 0.7,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Row(
              children: [
                SkeletonLoader(
                  height: 12,
                  width: 60,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                SkeletonLoader(
                  height: 12,
                  width: 70,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                SkeletonLoader(
                  height: 12,
                  width: 50,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserCardSkeleton extends StatelessWidget {
  const UserCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingXS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            SkeletonLoader(
              height: 48,
              width: 48,
              borderRadius: BorderRadius.circular(24),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(
                    height: 16,
                    width: 120,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 4),
                  SkeletonLoader(
                    height: 14,
                    width: 180,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListSkeleton extends StatelessWidget {
  final int itemCount;
  final Widget skeletonItem;

  const ListSkeleton({
    Key? key,
    required this.itemCount,
    required this.skeletonItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => skeletonItem,
    );
  }
}