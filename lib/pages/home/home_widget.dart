import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22.0,
                ),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Add your home page content here
                Center(
                  child: Text(
                    'Welcome ${appState.firstName}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}