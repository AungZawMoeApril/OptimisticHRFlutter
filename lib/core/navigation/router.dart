import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../injection_container.dart';
import '../providers/app_state_provider.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/time_attendance/presentation/pages/time_attendance_page.dart';
import '../../features/announcement/domain/entities/announcement.dart';
import '../../features/announcement/presentation/bloc/announcement_bloc.dart';
import '../../announment/announcement/announcement_widget.dart';
import '../../features/announcement/presentation/pages/announcements_page.dart';
import '../../features/leave/presentation/pages/leave_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

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
        
        // Time Attendance
        GoRoute(
          path: '/timeAttendance',
          name: 'timeAttendance',
          builder: (context, state) => const TimeAttendancePage(),
        ),

        // Announcements
        GoRoute(
          path: '/announcements',
          name: 'announcements',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AnnouncementBloc>(),
            child: const AnnouncementsPage(),
          ),
          routes: [
            GoRoute(
              path: 'detail/:id',
              name: 'announcementDetail',
              builder: (context, state) {
                final announcement = state.extra as Announcement;
                return AnnouncementWidget(announcement: announcement);
              },
            ),
          ],
        ),

        // Leave Management
        GoRoute(
          path: '/leave',
          name: 'leave',
          builder: (context, state) => const LeavePage(),
        ),

        // Profile
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),

        // Settings
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
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
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),

  // Route guards
  redirect: (BuildContext context, GoRouterState state) {
    // Check if user is authenticated
    final state = context.read<AppStateProvider>();
    final bool isAuthenticated = state.isAuthenticated;
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
  void goNamed(String name, {Map<String, dynamic>? params}) {
    GoRouter.of(this).goNamed(
      name,
      params: params,
    );
  }

  void pushNamed(String name, {Map<String, dynamic>? params}) {
    GoRouter.of(this).pushNamed(
      name,
      params: params,
    );
  }

  void pop<T>([T? result]) {
    GoRouter.of(this).pop(result);
  }
}