import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;

  const LoadingWidget({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 24.0,
        height: size ?? 24.0,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primary,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;

  const LoadingOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LoadingWidget(size: 32.0),
                      if (message != null) ...[
                        const SizedBox(height: 16.0),
                        Text(
                          message!,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}