import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../leave/leave_request/leave_request_widget.dart';
import '../../leave/leave_request_edit_main/leave_request_edit_main_widget.dart';
import '../../check_in_check_out/check_in/check_in_widget.dart';
import '../../check_in_check_out/check_out/check_out_widget.dart';
import '../../my_info/profile/profile_widget.dart';
import '../../pages/login_page/login_page_widget.dart';
import '../../time_attandance/time_attendance_list/time_attendance_list_widget.dart';
import '../../pages/home/home_widget.dart';
import '../../features/announcement/presentation/pages/announcement_page.dart';
import '../../my_info/settings/settings_widget.dart';
import '../providers/app_state_provider.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Auth
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPageWidget(),
      ),
      
      // Leave Management
      GoRoute(
        path: '/leave',
        name: 'leave',
        builder: (context, state) => const LeaveRequestWidget(),
        routes: [
          GoRoute(
            path: 'edit',
            name: 'leaveEdit',
            builder: (context, state) => LeaveRequestEditMainWidget(
              editLeaveRequest: state.extra,
            ),
          ),
        ],
      ),
      
      // Time Attendance
      GoRoute(
        path: '/attendance',
        name: 'attendance',
        builder: (context, state) => const TimeAttendanceListWidget(),
        routes: [
          GoRoute(
            path: 'check-in',
            name: 'checkIn',
            builder: (context, state) => const CheckInWidget(),
          ),
          GoRoute(
            path: 'check-out',
            name: 'checkOut',
            builder: (context, state) => const CheckOutWidget(),
          ),
        ],
      ),
      
      // Profile & Settings
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileWidget(),
      ),
      
      // Main Navigation
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeWidget(),
      ),
      GoRoute(
        path: '/announcements',
        name: 'announcements',
        builder: (context, state) => const AnnouncementPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings', 
        builder: (context, state) => const SettingsWidget(),
      ),
    ],
    redirect: _handleRedirect,
  );
  
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final appState = context.read<AppStateProvider>();
    final bool isAuthenticated = appState.isAuthenticated;
    final bool isGoingToLogin = state.matchedLocation == '/login';
    
    // If user is not authenticated and not going to login, redirect to login
    if (!isAuthenticated && !isGoingToLogin) {
      return '/login';
    }
    
    // If user is authenticated and going to login, redirect to home
    if (isAuthenticated && isGoingToLogin) {
      return '/home';
    }
    
    return null;
  }
}