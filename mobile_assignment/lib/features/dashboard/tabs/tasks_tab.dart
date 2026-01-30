import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_assignment/core/theme/app_theme.dart'; // Ensure you have this package or use basic string formatting

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  // Mock Data for the Calendar
  final List<DateTime> _dates = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );
  int _selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          spacing: 24,
          children: [
            _buildHeader(),
            _buildCalender(),
            _buildVerticalCalender(),
            _tasksHeader(),
            _buildTaskList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.secondaryPurple.withAlpha(50),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.grey,
            ),
            onPressed: () {}, // No back action needed in Tab
          ),
        ),
        const Text(
          "My Tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.search, size: 24, color: Colors.grey),
      ],
    );
  }

  Widget _buildCalender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('MMMM yyyy').format(DateTime.now()),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF252836),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Text("Weekly", style: TextStyle(color: Colors.grey)),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalCalender() {
    return Container(
      height: 60,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = index == _selectedDateIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedDateIndex = index),
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? const Color(0xFF6C5DD3)
                        : const Color(0xFF252836),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tasksHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Todays Task",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF252836), // Dark button
            foregroundColor: const Color(0xFF6C5DD3), // Purple Text
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
          ),
          child: const Text("Add Task +"),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: ListView(
        children: [
          _buildTaskCard(
            title: "Google Map API",
            subtitle:
                "Web APIs. Maps Embed API. Add a Google Map to your site.",
            progress: 0.7,
            color: const Color(0xFF6C5DD3),
          ),
          _buildTaskCard(
            title: "Intercom Chatbot UI",
            subtitle:
                "Intercom is the only complete Customer Service solution.",
            progress: 0.45,
            color: Colors.orangeAccent,
          ),
          _buildTaskCard(
            title: "Backend Integration",
            subtitle: "Connect Flutter app with Spring Boot APIs.",
            progress: 1.0,
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String subtitle,
    required double progress,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252836),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit, color: Colors.grey, size: 20),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildAvatarStack()),
                    _circularProgressBar(progress, color),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarStack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Stack(
            children: [
              _avatar(0, "https://i.pravatar.cc/150?img=33"),
              _avatar(20, "https://i.pravatar.cc/150?img=47"),
              _avatar(40, "https://i.pravatar.cc/150?img=12"),
              Positioned(
                left: 60,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C5DD3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "+3",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Text(
          "Due: 28 Jan 2026",
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
      ],
    );
    // return SizedBox(
    //   width: 80,
    //   height: 30,
    //   child: Stack(
    //     children: [
    //       _avatar(0, "https://i.pravatar.cc/150?img=33"),
    //       _avatar(20, "https://i.pravatar.cc/150?img=47"),
    //       _avatar(40, "https://i.pravatar.cc/150?img=12"),
    //       Positioned(
    //         left: 60,
    //         child: Container(
    //           width: 30,
    //           height: 30,
    //           decoration: const BoxDecoration(
    //             color: Color(0xFF6C5DD3),
    //             shape: BoxShape.circle,
    //           ),
    //           child: const Center(
    //             child: Text(
    //               "+3",
    //               style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _circularProgressBar(double progress, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 3,
            backgroundColor: color.withOpacity(0.1),
            color: color,
          ),
        ),
        Text(
          "${(progress * 100).toInt()}%",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }

  Widget _avatar(double left, String url) {
    return Positioned(
      left: left,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF252836), width: 2),
        ),
        child: CircleAvatar(radius: 14, backgroundImage: NetworkImage(url)),
      ),
    );
  }
}
