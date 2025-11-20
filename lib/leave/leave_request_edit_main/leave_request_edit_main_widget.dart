import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:h_r_optimistic_mobile/app_state.dart';
import 'package:h_r_optimistic_mobile/backend/api_requests/api_calls.dart';
import 'package:h_r_optimistic_mobile/core/utils/app_utils.dart';
import 'package:h_r_optimistic_mobile/core/utils/localization_utils.dart';
import 'package:h_r_optimistic_mobile/core/theme/flutter_flow_theme.dart';
import 'package:h_r_optimistic_mobile/core/widgets/app_button.dart';
import 'package:h_r_optimistic_mobile/core/widgets/app_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'leave_request_edit_main_model.dart';
export 'leave_request_edit_main_model.dart';

class LeaveRequestEditMainWidget extends StatefulWidget {
  const LeaveRequestEditMainWidget({
    super.key,
    required this.editLeaveRequest,
  });

  final dynamic editLeaveRequest;

  static const String routeName = 'LeaveRequestEditMain';
  static const String routePath = '/leaveRequestEditMain';

  @override
  State<LeaveRequestEditMainWidget> createState() =>
      _LeaveRequestEditMainWidgetState();
}

class _LeaveRequestEditMainWidgetState
    extends State<LeaveRequestEditMainWidget> {
  late LeaveRequestEditMainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaveRequestEditMainModel());

    _model.txtDescriptionTextController ??= TextEditingController();
    _model.txtDescriptionFocusNode ??= FocusNode();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            color: Theme.of(context).colorScheme.onSurface,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'edit_leave',
          ),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: GoogleFonts.outfit().fontFamily,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 22.0,
                letterSpacing: 0.0,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText('description'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _model.txtDescriptionTextController,
                            focusNode: _model.txtDescriptionFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: FFLocalizations.of(context).getText('enter_description'),
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 4,
                          ),
                          SizedBox(height: 16.0),
                          AppButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            text: FFLocalizations.of(context).getText('save'),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              color: Theme.of(context).colorScheme.primary,
                              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                              elevation: 2.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
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
