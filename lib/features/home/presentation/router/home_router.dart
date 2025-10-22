import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/providers/home_provider.dart';
import '../presentation/pages/home_page.dart';

class HomeRouter {
  static const String routeName = HomePage.routeName;
  static const String routePath = HomePage.routePath;

  static Widget page() {
    return ChangeNotifierProvider(
      create: (context) => Provider.of<HomeProvider>(context, listen: false),
      child: const HomePage(),
    );
  }
}