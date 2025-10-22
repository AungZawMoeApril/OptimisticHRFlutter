import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:hr_app/core/utils/app_utils.dart';
import 'package:hr_app/core/widgets/app_button.dart';
import 'package:hr_app/core/theme/app_button_style.dart';
import 'package:hr_app/core/l10n/app_localizations.dart';
import '/index.dart';

class OnSiteDetailWidget extends StatefulWidget {
  const OnSiteDetailWidget({super.key});

  static String routeName = 'OnSiteDetail';
  static String routePath = '/onSiteDetail';

  @override
  State<OnSiteDetailWidget> createState() => _OnSiteDetailWidgetState();
}

class _OnSiteDetailWidgetState extends State<OnSiteDetailWidget> {
  late OnSiteDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnSiteDetailModel());

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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.angleLeft,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            AppLocalizations.of(context)!.onSiteDetail,
            style: Theme.of(context).textTheme.titleLarge.copyWith(
              fontSize: 22.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: AppButton(
                  text: AppLocalizations.of(context)!.createOnSite,
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(368.0, 40.0),
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    backgroundColor: const Color(0xFFF9B052),
                    textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                    elevation: 3.0,
                    side: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xFFF9B052),
                                      width: 4,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.location_pin),
                                        title: Text(
                                          AppLocalizations.of(context)!.location,
                                          style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                            color: Theme.of(context).colorScheme.onBackground,
                                          ),
                                        ),
                                        trailing: const Icon(
                                          FontAwesomeIcons.angleDown,
                                          size: 17,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: AppButton(
                                          text: AppLocalizations.of(context)!.checkIn,
                                          onPressed: () {
                                            context.read<AppState>().timeType = TimeType.checkOut;
                                            Navigator.of(context).pushNamed(CheckOutWidget.routeName);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size.fromHeight(30),
                                            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            backgroundColor: const Color(0xFFF9B052),
                                            textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                            elevation: 3,
                                            side: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}