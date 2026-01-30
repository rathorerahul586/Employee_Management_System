import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employee_cubit.dart';
import '../data/employee_model.dart'; // Import your models

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C5DD3)),
            );
          } else if (state is EmployeeError) {
            return Center(child: Text(state.message));
          } else if (state is EmployeeLoaded) {
            return _buildDepartmentList(state.departments);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDepartmentList(List<Department> departments) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final dept = departments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Department Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                dept.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            // Employee Cards
            ...dept.employees.map((emp) => _buildEmployeeCard(emp)),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildEmployeeCard(Employee emp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252836), // Card Dark Color
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF6C5DD3).withOpacity(0.2),
            child: Text(
              emp.name[0],
              style: const TextStyle(
                color: Color(0xFF6C5DD3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emp.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  emp.position,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          // Salary Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5DD3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "\$${emp.salary.toStringAsFixed(0)}",
              style: const TextStyle(
                color: Color(0xFF6C5DD3),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
