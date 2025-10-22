import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/core/theme/app_theme_extension.dart';
import 'package:hr_app/core/widgets/app_web_view.dart';
import 'package:hr_app/core/widgets/app_icon_button.dart';
import 'package:hr_app/core/utils/app_utils.dart';
import 'package:hr_app/core/l10n/app_localizations.dart';
import '/index.dart';
import 'announcement_web_view_model.dart';
export 'announcement_web_view_model.dart';

class AnnouncementWebViewWidget extends StatefulWidget {
  const AnnouncementWebViewWidget({
    super.key,
    required this.announcementMobileViewURL,
  });

  final int? announcementMobileViewURL;

  static String routeName = 'AnnouncementWebView';
  static String routePath = '/announcementWebView';

  @override
  State<AnnouncementWebViewWidget> createState() =>
      _AnnouncementWebViewWidgetState();
}

class _AnnouncementWebViewWidgetState extends State<AnnouncementWebViewWidget> {
  late AnnouncementWebViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnnouncementWebViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

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
              '2179gwex' /* Announcement Detail */,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AppWebView(
                  url: '${AppState().AnnouncementwebviewLink}${widget.announcementMobileViewURL?.toString()}',
                  bypass: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
