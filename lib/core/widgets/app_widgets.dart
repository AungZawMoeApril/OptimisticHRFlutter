import 'package:flutter/material.dart';

// FlutterFlowButtonTabBar stub
Widget FlutterFlowButtonTabBar({
  required List<Tab> tabs,
  required TabController controller,
  TextStyle? labelStyle,
  TextStyle? unselectedLabelStyle,
  Color? labelColor,
  Color? unselectedLabelColor,
  Color? backgroundColor,
  Color? unselectedBackgroundColor,
  double? borderWidth,
  Color? borderColor,
  double? elevation,
  BorderRadius? borderRadius,
  EdgeInsets? padding,
}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.white,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
    ),
    child: TabBar(
      controller: controller,
      tabs: tabs,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicator: BoxDecoration(
        color: unselectedBackgroundColor ?? Colors.grey.shade200,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    ),
  );
}

// Navigation parameter types
enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DataStruct,
  JSON,
}

// OvertimeAttachmentModelWidget stub
Widget OvertimeAttachmentModelWidget({
  dynamic oTRequestID,
  List<String>? attachmentList,
}) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: (attachmentList ?? []).map((attachment) {
        return Chip(
          label: Text(attachment),
          avatar: const Icon(Icons.attachment, size: 16),
        );
      }).toList(),
    ),
  );
}

class AppWidgets {
  static Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  static Widget buildEmptyWidget(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
