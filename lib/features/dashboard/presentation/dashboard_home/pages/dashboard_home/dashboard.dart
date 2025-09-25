import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/utils/secure_storage.dart';
import '../../widgets/custom_menu_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SecureStorage.getToken(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          final token = snapshot.hasData;
          if (token == null){
            Future.microtask(() => context.go('/login_signup'));
            return const SizedBox.shrink();
          }
          return Scaffold(
            body: Row(
              children: [
                Container(
                  width: 220,
                  color: AppColors.smooky,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          "لوحة التحكم",
                          style: TextStyle(
                            color: AppColors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomMenuItem(
                        icon: Icons.store,
                        title: "الفروع",
                        onTap: () => context.go('/branches'),
                      ),
                      CustomMenuItem(
                        icon: Icons.fastfood,
                        title: "الأصناف",
                        onTap: () => context.go('/categories'),
                      ),
                      CustomMenuItem(
                        icon: Icons.fastfood,
                        title: "الوجبات",
                        onTap: () => context.go('/meals'),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await SecureStorage.deleteToken();
                            context.go('/login_signup');
                          },
                          icon: const Icon(Icons.logout, color: AppColors.white),
                          label: const Text(
                            'تسجيل الخروج',
                            style: TextStyle(color: AppColors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.smooky2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: Container(
                    color: AppColors.smooky2,
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
