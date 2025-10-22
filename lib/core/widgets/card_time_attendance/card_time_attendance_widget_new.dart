import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CardTimeAttendanceWidgetViewModel extends BaseViewModel {
  
}

class CardTimeAttendanceWidget extends StatelessWidget {
  const CardTimeAttendanceWidget({
    super.key,
    this.location,
    this.checkIn,
    this.checkOut,
    this.checkInAndOuttype,
    required this.checkInStatus,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CardTimeAttendanceWidgetViewModel>(
      viewModelBuilder: () => CardTimeAttendanceWidgetViewModel(),
      builder: (context, model, child) {
        return return Align(
      alignment: AlignmentDirectional(-1.0, -1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
        child: Container(
          width: double.infinity,
          height: 115.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryBackground,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.0, -1.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Container(
                        width: 5.0,
                        height: 115.0,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryBackground,
                          borderRadius: BorderRadius.circular(0.0),
                          border: Border.all(
                            color: Color(0xFFF9B052),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    valueOrDefault<String>(
                                      widget.location?.toString(),
                                      'location',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                if ('Normal' !=
                                    widget.checkInAndOuttype?.toString())
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 5.0, 0.0),
                                        child: Text(
                                          () {
                                            if (widget.checkInStatus == 3) {
                                              return 'On-Site';;
      },
    );
  }
}
