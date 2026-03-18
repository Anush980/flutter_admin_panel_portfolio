import 'package:flutter/material.dart';
import 'package:portfolio_admin/config/routes/app_router.dart';
import 'package:portfolio_admin/config/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // wauu, This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Portfolio Admin',
      theme: AppTheme.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
