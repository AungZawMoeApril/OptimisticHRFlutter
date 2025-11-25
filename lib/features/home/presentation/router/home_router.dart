import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../pages/home_page.dart';

class HomeRouter {
  static String get routeName => HomePage.routeName;
  static String get routePath => HomePage.routePath;

  static Widget page() {
    return ChangeNotifierProvider(
      create: (context) => Provider.of<HomeProvider>(context, listen: false),
      child: const HomePage(),
    );
  }
}