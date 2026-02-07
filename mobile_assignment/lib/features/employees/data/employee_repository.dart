import '../../../core/network/api_client.dart';
import 'employee_model.dart';

class EmployeeRepository {
  final ApiClient apiClient;

  EmployeeRepository({required this.apiClient});

  Future<List<Department>> getDepartments() async {
    try {
      final response = await apiClient.get('/departments');
      final List<dynamic> rawList = response.data['data'];
      return rawList.map((json) => Department.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Data Parse Error: $e");
    }
  }

  Future<List<dynamic>> getEmployees() async {
    final response = await apiClient.get('/employees');
    return response.data;
  }
}
