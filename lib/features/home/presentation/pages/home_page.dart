import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widgets/personal_info_card.dart';
import '../widgets/attendance_card_v2.dart';
import '../widgets/announcement_list.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import 'package:hr_app/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primaryBackground,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 40,
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Badge(
                              label: Text(
                                provider.notificationCount.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              child: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pushNamed('NotificationPage');
                            },
                          ),
                          CustomIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: const Icon(
                              Icons.qr_code_scanner_outlined,
                              color: Colors.black,
                              size: 24,
                            ),
                            onPressed: () async {
                              Navigator.of(context).pushNamed('ScanQrPage');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: provider.isLoading && provider.personalInfo == null
                      ? const Center(child: CircularProgressIndicator())
                      : provider.error != null
                          ? Center(child: Text(provider.error!))
                          : RefreshIndicator(
                              onRefresh: () => provider.loadHomeData(),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (provider.personalInfo != null) ...[
                                      PersonalInfoCard(
                                        personalInfo: provider.personalInfo!,
                                      ),
                                      const AttendanceCardV2(),
                                      AnnouncementList(
                                        announcements: provider.announcements,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}