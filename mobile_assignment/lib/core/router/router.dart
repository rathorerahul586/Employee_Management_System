import 'package:flutter/material.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/dashboard/ui/dashboard_screen.dart';

class AppRouter {
  // Define Route Names
  static const String login = '/';
  static const String dashboard = '/dashboard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(child: Text('Error: Route not found!')),
      );
    });
  }
}