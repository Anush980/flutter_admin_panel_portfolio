import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_admin/config/routes/route_names.dart';
import 'package:portfolio_admin/core/storage/secure_storage.dart';

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("$title - nothing to see here dude")),
    );
  }
}

final appRouter = GoRouter(
  initialLocation: RouteNames.dashboard,
  redirect: (context, state) async {


  String? token;

  try {
    token = await SecureStorage.getToken();
  } catch (e) {
    token = null; // fallback for Linux developement 
  }

    final isLoggedIn = token != null;
    final isGoingToLogin = state.matchedLocation == RouteNames.login;

    if (!isLoggedIn && !isGoingToLogin) return RouteNames.login;
    if (isLoggedIn && isGoingToLogin) return RouteNames.dashboard;
    return null;
  },
  routes: [
    // (_ ,__) this means like we are not gonna use this like it can be context and state but no means no

    //login route
    GoRoute(
      path: RouteNames.login,
      builder: (_, __) => const _PlaceholderScreen('Login'),
    ),

    //register route
    GoRoute(
      path: RouteNames.register,
      builder: (_, __) => const _PlaceholderScreen('Register'),
    ),

    //dashboard route
    GoRoute(
      path: RouteNames.dashboard,
      builder: (_, __) => const _PlaceholderScreen('Dashboard'),
    ),

    //profile route
    GoRoute(
      path: RouteNames.profile,
      builder: (_, __) => const _PlaceholderScreen('Profile'),
    ),

    //skills route
    GoRoute(
      path: RouteNames.skills,
      builder: (_, __) => const _PlaceholderScreen('Skills'),
    ),

    //experience route
    GoRoute(
      path: RouteNames.experience,
      builder: (_, __) => const _PlaceholderScreen('experience'),
    ),

    //education route
    GoRoute(
      path: RouteNames.education,
      builder: (_, __) => const _PlaceholderScreen('education'),
    ),

    //certificate route
    GoRoute(
      path: RouteNames.certificates,
      builder: (_, __) => const _PlaceholderScreen('certificate'),
    ),

    //project route
    GoRoute(
      path: RouteNames.projects,
      builder: (_, __) => const _PlaceholderScreen('Project'),
    ),

    //activties route
    GoRoute(
      path: RouteNames.activities,
      builder: (_, __) => const _PlaceholderScreen('Activities'),
    ),

    //social links route
    GoRoute(
      path: RouteNames.socialLinks,
      builder: (_, __) => const _PlaceholderScreen('Social lInks'),
    ),

    //messages route
    GoRoute(
      path: RouteNames.messages,
      builder: (_, __) => const _PlaceholderScreen('Messages'),
    ),

    //chat route
    GoRoute(
      path: RouteNames.chat,
      builder: (_, __) => const _PlaceholderScreen('AI chat'),
    ),

    //admin route
    GoRoute(
      path: RouteNames.admin,
      builder: (_, __) => const _PlaceholderScreen('Admin'),
    ),
  ],
);
