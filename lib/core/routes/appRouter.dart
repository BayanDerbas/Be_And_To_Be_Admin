import 'package:be_and_to_be_admin/features/branches/presentation/pages/branches_page.dart';
import 'package:be_and_to_be_admin/features/meals/presentation/pages/meals_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login&signup.dart';
import '../../features/categories/presentation/pages/categories_page.dart';
import '../../features/dashboard/presentation/dashboard_home/pages/dashboard_home/dashboard.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login_signup',
    routes: [
      GoRoute(
        path: '/login_signup',
        builder: (context, state) => Login_SignupPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => DashboardPage(child: child),
        routes: [
          GoRoute(
            path: '/dash',
            builder:
                (context, state) =>
                    const Center(child: Text("🍔 محتوى الصفحة الرئيسية")),
          ),
          GoRoute(
            path: '/branches',
            builder:
                (context, state) => BranchesPage(),
          ),
          GoRoute(
            path: '/categories',
            builder: (context, state) => CategoriesPage(),
          ),
          GoRoute(
            path: '/meals',
            builder: (context,state) => MealsPage(),
          ),
        ],
      ),
    ],
  );
}
