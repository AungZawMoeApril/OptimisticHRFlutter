import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/screens/pin_code_screen.dart';
import '../../features/auth/presentation/screens/pin_code_setup_screen.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/check_in/presentation/pages/check_in_page.dart';
import '../../features/check_out/presentation/pages/check_out_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/pin-code',
        name: 'pinCode',
        builder: (context, state) => const PinCodeScreen(),
      ),
      GoRoute(
        path: '/pin-code-setup',
        name: 'pinCodeSetup',
        builder: (context, state) => const PinCodeSetupScreen(),
      ),
      
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNav(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'check-in',
                name: 'checkIn',
                builder: (context, state) => const CheckInPage(),
              ),
              GoRoute(
                path: 'check-out',
                name: 'checkOut',
                builder: (context, state) => const CheckOutPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    
    redirect: (context, state) {
      final appState = context.read<AppState>();
      final isLoggedIn = appState.token.isNotEmpty;
      final isAuth = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/home');

      // Not logged in, redirect to login
      if (!isLoggedIn && !isAuth) {
        return '/login';
      }

      // All authenticated, redirect from auth screens to home
      if (isLoggedIn && isAuth) {
        return '/home';
      }

      return null;
    },
  );
}

class ScaffoldWithBottomNav extends StatelessWidget {
  const ScaffoldWithBottomNav({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Check In'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Check Out'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/home/check-in');
              break;
            case 2:
              context.go('/home/check-out');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/check-in')) {
      return 1;
    }
    if (location.startsWith('/check-out')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }
}