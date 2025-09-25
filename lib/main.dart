import 'package:be_and_to_be_admin/features/meals/presentation/cubits/meal_types_cubit/meal_types_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/ResponsiveUI/responsiveConfig.dart';
import 'config/theme/app_theme.dart';
import 'core/di/injection.dart' as di;
import 'core/firebase/firebase_options.dart';
import 'core/routes/appRouter.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/login/login_cubit.dart';
import 'features/auth/presentation/cubit/logout/logout_cubit.dart';
import 'features/auth/presentation/cubit/refresh/refresh_cubit.dart';
import 'features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'features/notifications/data/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  await NotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<RefreshCubit>(create: (_) => di.sl<RefreshCubit>()),
        BlocProvider<LogoutCubit>(create: (_) => di.sl<LogoutCubit>()),
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<BranchCubit>(create: (_) => di.sl<BranchCubit>()..fetchBranches(),),
        BlocProvider<MealTypesCubit>(create: (_) => di.sl<MealTypesCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return ResponsiveConfig(
            context: context,
            child: MaterialApp.router(
              theme: AppTheme.lightTheme,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ResponsiveConfig.of(context).isDesktop ||
                    ResponsiveConfig.of(context).isTablet
                    ? child!
                    : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
