import 'package:flutter/material.dart';
import 'package:mobile_assignment/core/theme/app_theme.dart';
import 'package:mobile_assignment/features/dashboard/tabs/tasks_tab.dart';
import '../../employees/ui/employee_list_screen.dart';
import '../../profile/ui/profile_screen.dart';
import '../../attendance/ui/attendance_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const AttendanceScreen(),
    const TasksTab(),
    const EmployeeListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.secondaryPurple,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, Icons.home_filled, "Home"),
            _buildNavItem(1, Icons.calendar_today, "Tasks"),
            _buildNavItem(2, Icons.near_me, "Projects"),
            _buildNavItem(3, Icons.person, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
