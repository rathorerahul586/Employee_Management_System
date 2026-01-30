import 'package:get_it/get_it.dart';
import '../../features/employees/cubit/employee_cubit.dart';
import '../../features/employees/data/employee_repository.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // API client
  sl.registerLazySingleton(() => ApiClient());

  // Repositories
  sl.registerLazySingleton(() => EmployeeRepository(apiClient: sl()));

  // Cubits
  sl.registerFactory(() => EmployeeCubit(repository: sl()));


}
