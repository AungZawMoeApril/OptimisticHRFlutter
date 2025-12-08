import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/announcement/presentation/pages/announcements_page.dart';
import '../../leave/leave_page/leave_page_widget.dart';
import '../../my_info/profile/profile_widget.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        // Wrap child with common layout like drawer, bottom navigation, etc.
        return child;
      },
      routes: [
        // Home
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),

        // Announcements
        GoRoute(
          path: '/announcements',
          name: 'announcements',
          builder: (context, state) => const AnnouncementsPage(),
        ),

        // Leave Management
        GoRoute(
          path: '/leave',
          name: 'leave',
          builder: (context, state) => const LeavePageWidget(),
        ),

        // Profile
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileWidget(),
        ),

        // Authentication
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
      ],
    ),
  ],

  // Error handling
  errorBuilder: (context, state) => material.Scaffold(
    body: material.Center(
      child: material.Text('Error: ${state.error}'),
    ),
  ),

  // Route guards
  redirect: (BuildContext context, GoRouterState state) {
    // Check if user is authenticated
    final appState = context.read<AppStateProvider>();
    final bool isAuthenticated = appState.isAuthenticated;
    final bool isGoingToLogin = state.matchedLocation == '/login';

    if (!isAuthenticated && !isGoingToLogin) {
      return '/login';
    }

    if (isAuthenticated && isGoingToLogin) {
      return '/';
    }

    return null;
  },
);

// Extension methods for easy navigation
extension GoRouterExtensions on BuildContext {
  void goNamed(String name, {Map<String, String>? params}) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: params ?? {},
    );
  }

  void pushNamed(String name, {Map<String, String>? params}) {
    GoRouter.of(this).pushNamed(
      name,
      pathParameters: params ?? {},
    );
  }

  void pop<T>([T? result]) {
    GoRouter.of(this).pop(result);
  }
}
