import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/utils/secure_storage.dart';
import '../../widgets/custom_menu_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveConfig.of(context).isDesktop;
    final isTablet = ResponsiveConfig.of(context).isTablet;
    final isMobile = ResponsiveConfig.of(context).isMobile;
    final sidebarWidth = isMobile ? 190.0 : 220.0;
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
                  width: sidebarWidth,
                  color: AppColors.smooky,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لوحة التحكم",
                                  style: TextStyle(
                                    color: AppColors.amber,
                                    fontSize: isMobile ? 15 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 3),
                                IconButton(
                                  onPressed: () => context.go('/dash'),
                                  icon: Icon(
                                    Icons.water_damage_sharp,
                                    size: isMobile ? 25 : 40,
                                  ),
                                ),
                              ],
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
                            icon: Icons.restaurant,
                            title: "الوجبات",
                            onTap: () => context.go('/meals'),
                          ),
                          CustomMenuItem(
                            icon: Icons.sell,
                            title: "الكوبونات",
                            onTap: () => context.go('/coupons'),
                          ),
                          CustomMenuItem(
                            icon: Icons.shopping_cart_outlined,
                            title: "الطلبات",
                            onTap: () => context.go('/orders'),
                          ),
                          CustomMenuItem(
                            icon: Icons.folder_copy,
                            title: "الطلبات المقبولة",
                            onTap: () => context.go('/accepted_orders'),
                          ),
                          CustomMenuItem(
                            icon: Icons.archive,
                            title: "الأرشيف",
                            onTap: () => context.go('/archived_orders'),
                          ),

                          const SizedBox(height: 30),

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
                  ),
                ),
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
