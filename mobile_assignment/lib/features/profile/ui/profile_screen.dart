import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/router/router.dart';
import '../../../core/theme/app_theme.dart';
import '../cubit/profile_cubit.dart';
import '../../auth/ui/login_screen.dart'; // For Logout navigation

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({super.key});

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF252836),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: AppTheme.primaryPurple,
                ),
                title: const Text(
                  "Take Photo",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  context.read<ProfileCubit>().pickImage(ImageSource.camera);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: AppTheme.primaryPurple,
                ),
                title: const Text(
                  "Choose from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  context.read<ProfileCubit>().pickImage(ImageSource.gallery);
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileCard(context),

            const SizedBox(height: 32),

            _buildInfoTile(Icons.touch_app, "Punch History"),
            _buildInfoTile(Icons.calendar_month, "Leave Management"),
            _buildInfoTile(Icons.now_widgets_outlined, "Project"),
            _buildInfoTile(Icons.payments_outlined, "Payroll"),
            _buildInfoTile(Icons.disc_full_outlined, "Meal Management"),
            _buildInfoTile(Icons.people_alt_outlined, "Employees"),
            _logoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24,
        bottom: 24,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryPurple.withAlpha(50),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(24),
          right: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => _showPickerOptions(context),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryPurple.withAlpha(150),
                ),
                child: Icon(Icons.mode_edit_outlined, color: Colors.grey),
              ),
            ),
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              File? imageFile;
              if (state is ProfileImageSelected) {
                imageFile = state.imageFile;
              }
              return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:
                        imageFile != null
                            ? FileImage(imageFile) as ImageProvider
                            : const NetworkImage(
                              "https://i.pravatar.cc/300?img=11",
                            ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16, width: double.infinity),
          const Text(
            "Rahul Kumar",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text("Mobile Developer", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryPurple.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 16,
        children: [
          Icon(icon, color: Colors.grey),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryPurple,
                ),
                child: Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.white70,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRouter.login);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            const Icon(Icons.logout, color: Colors.red),
            const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
