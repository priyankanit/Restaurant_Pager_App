import 'package:get/get.dart';
import 'package:restuarant_pager_app/views/LoginView/loginPage.dart';
import 'package:restuarant_pager_app/views/SignUpView/signUpPage.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard_binding.dart';
import 'package:restuarant_pager_app/views/pages/onboarding/boarding_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/boarding_screens',
      page: () => BoardingScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/signup',
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const Dashboard(),
      binding: DashboardBinding(),
    ),
  ];
}
