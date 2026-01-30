import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/ui/login_screen.dart';
import 'features/employees/cubit/employee_cubit.dart';
import 'features/employees/data/employee_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Global Notification Object
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetIt
  await di.init();
  _initNotifications();

  // Register Repo/Cubit manually in DI for now to avoid errors in step 3
  if (!di.sl.isRegistered<EmployeeRepository>()) {
    di.sl.registerLazySingleton(() => EmployeeRepository(apiClient: di.sl()));
  }
  if (!di.sl.isRegistered<EmployeeCubit>()) {
    di.sl.registerFactory(() => EmployeeCubit(repository: di.sl()));
  }

  runApp(const MyApp());
}

Future<void> _initNotifications() async {
  // Android Settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS Settings
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

  // Combine
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<EmployeeCubit>()..fetchDepartments()),
      ],
      child: MaterialApp(
        title: 'Demo application',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRouter.login,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: LoginScreen(),
      ),
    );
  }
}
