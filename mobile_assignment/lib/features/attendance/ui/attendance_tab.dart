import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:mobile_assignment/core/extensions/extensions.dart';
import 'package:mobile_assignment/core/theme/app_theme.dart';

import '../../../main.dart';
import '../cubit/attendance_cubit.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceCubit(),
      child: const AttendanceTab(),
    );
  }
}

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({super.key});

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Pulse Animation for the button
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
    }

    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();

    if (iosImplementation != null) {
      await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [_buildHeader(), _searchBar(), ..._attendanceCard()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6C5DD3), width: 2),
              ),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=11",
                ), // Mock Image
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.widgets)),
          ],
        ),
        Text(
          "Hi Rahul",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF252836),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  List<Widget> _attendanceCard() {
    return [
      const Text(
        "Attendance",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      _buildAnimatedPunchButton(),
      _buildTimingCard(),
    ];
  }

  Widget _buildAnimatedPunchButton() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF252836),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCurrentTime(),

          const SizedBox(height: 24),

          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glow
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryPurple.withOpacity(
                        0.1 - (_controller.value * 0.1),
                      ),
                    ),
                  );
                },
              ),
              // Inner Glow
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryPurple.withAlpha(90),
                ),
              ),
              // The Button
              GestureDetector(
                onTap: () {
                  context.read<AttendanceCubit>().punchInOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Punched Successfully!")),
                  );
                  _showNotification();
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF8B7EF8), Color(0xFF6C5DD3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6C5DD3),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.touch_app_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<AttendanceCubit, AttendanceCubitState>(
                        builder: (context, state) {
                          String buttonText =
                              state.checkinsTime == null
                                  ? "PUNCH IN"
                                  : state.checkoutTime == null
                                  ? "PUNCH OUT"
                                  : "RESET";
                          return Text(
                            buttonText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Location: You are in Office",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTime() {
    return BlocSelector<AttendanceCubit, AttendanceCubitState, DateTime>(
      selector: (state) => state.currentTime,
      builder: (context, now) {
        debugPrint("time updated - $now");
        return Column(
          children: [
            Text(
              DateFormat('hh:mm a').format(now),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 2),
            Text(
              DateFormat('EE, MMM dd').format(now),
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimingCard() {
    return BlocBuilder<AttendanceCubit, AttendanceCubitState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF252836),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn(
                Icons.history,
                Colors.green,
                state.checkinsTime == null
                    ? "--:--"
                    : DateFormat('hh:mm a').format(state.checkinsTime!),
                "Check In",
              ),
              _buildStatColumn(
                Icons.history,
                Colors.orange,
                state.checkoutTime == null
                    ? "--:--"
                    : DateFormat('hh:mm a').format(state.checkoutTime!),
                "Check Out",
              ),

              _buildStatColumn(
                Icons.access_time,
                AppTheme.primaryPurple,
                context.read<AttendanceCubit>().workingTime().toHoursMinutes(),
                "Working Hrs",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatColumn(
    IconData icon,
    Color iconColor,
    String time,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'attendance_channel',
          'Attendance',
          channelDescription: 'Notifications for Punch In/Out',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Success!',
      'You have successfully Punched In at ${context.read<AttendanceCubit>().state.currentTime}',
      platformChannelSpecifics,
    );
  }
}
