class Employee {
  final String id;
  final String name;
  final String email;
  final String position;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? '',
      position: json['position'] ?? '',
      salary: (json['salary'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Department {
  final String id;
  final String name;
  final String location;
  final List<Employee> employees;

  Department({
    required this.id,
    required this.name,
    required this.location,
    required this.employees,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      employees:
          (json['employees'] as List<dynamic>?)
              ?.map((e) => Employee.fromJson(e))
              .toList() ??
          [],
    );
  }
}
