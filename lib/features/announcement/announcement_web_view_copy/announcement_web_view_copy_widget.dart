import 'package:hr_optimistic/core/theme/app_theme_extension.dart';
import '../core/widgets/app_widgets.dart';
import '../core/widgets/app_icon_button.dart';;
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'announcement_web_view_copy_model.dart';
export 'announcement_web_view_copy_model.dart';

class AnnouncementWebViewCopyWidget extends StatefulWidget {
  const AnnouncementWebViewCopyWidget({
    super.key,
    required this.announcementMobileViewURL,
  });

  final int? announcementMobileViewURL;

  static String routeName = 'AnnouncementWebViewCopy';
  static String routePath = '/announcementWebViewCopy';

  @override
  State<AnnouncementWebViewCopyWidget> createState() =>
      _AnnouncementWebViewCopyWidgetState();
}

class _AnnouncementWebViewCopyWidgetState
    extends State<AnnouncementWebViewCopyWidget> {
  late AnnouncementWebViewCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnnouncementWebViewCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.primaryBackground,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.tertiary,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.of(context).pushNamed(HomeWidget.routeName);
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'jb7szcjl' /* Announcement Detail */,
            ),
            style: Theme.of(context).textTheme.$1?.copyWith(
                  font: GoogleFonts.outfit(
                    fontWeight:
                        context.headlineMedium.fontWeight,
                    fontStyle:
                        context.headlineMedium.fontStyle,
                  ),
                  color: Theme.of(context).colorScheme.secondaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      context.headlineMedium.fontWeight,
                  fontStyle:
                      context.headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  child: custom_widgets.AnnouncementCustomWidget(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    weblink: 'https://gray-sky-09c66cd00.5.azurestaticapps.net',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
