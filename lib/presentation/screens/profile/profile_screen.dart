import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/loading_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context).pushReplacementNamed('/login');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: LoadingWidget());
          }

          if (state is AuthAuthenticated) {
            final user = state.user;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.primaryLight,
                          backgroundImage: user.avatar != null 
                              ? NetworkImage(user.avatar!) 
                              : null,
                          child: user.avatar == null
                              ? Text(
                                  user.name.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                // TODO: Handle avatar upload
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.defaultPadding),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.smallPadding),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  if (user.phone != null) ...[
                    const SizedBox(height: AppDimensions.smallPadding),
                    Text(
                      user.phone!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppDimensions.largePadding),
                  Card(
                    color: AppColors.cardColor,
                    elevation: AppDimensions.cardElevation,
                    child: Column(
                      children: [
                        _buildProfileOption(
                          context,
                          icon: Icons.edit,
                          title: 'Edit Profile',
                          onTap: () {
                            Navigator.of(context).pushNamed('/edit-profile');
                          },
                        ),
                        const Divider(height: 1),
                        _buildProfileOption(
                          context,
                          icon: Icons.lock,
                          title: 'Change Password',
                          onTap: () {
                            Navigator.of(context).pushNamed('/change-password');
                          },
                        ),
                        const Divider(height: 1),
                        _buildProfileOption(
                          context,
                          icon: Icons.notifications,
                          title: 'Notifications',
                          onTap: () {
                            Navigator.of(context).pushNamed('/notifications');
                          },
                        ),
                        const Divider(height: 1),
                        _buildProfileOption(
                          context,
                          icon: Icons.help,
                          title: 'Help & Support',
                          onTap: () {
                            Navigator.of(context).pushNamed('/help');
                          },
                        ),
                        const Divider(height: 1),
                        _buildProfileOption(
                          context,
                          icon: Icons.info,
                          title: AppStrings.about,
                          onTap: () {
                            Navigator.of(context).pushNamed('/about');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.largePadding),
                  CustomButton(
                    text: AppStrings.logout,
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    backgroundColor: AppColors.errorColor,
                    isFullWidth: true,
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text(
              'Unable to load profile',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.textSecondary,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(const LogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
            ),
            child: const Text(AppStrings.logout),
          ),
        ],
      ),
    );
  }
}