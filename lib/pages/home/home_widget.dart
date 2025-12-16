import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/features/home/presentation/pages/home_page.dart';

// Redirecting to the new home implementation
class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
