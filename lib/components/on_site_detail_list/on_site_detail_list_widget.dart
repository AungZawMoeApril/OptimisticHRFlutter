import 'package:flutter/material.dart';
import 'on_site_detail_list_model.dart';

export 'on_site_detail_list_model.dart';

/// Stub widget for OnSiteDetailList
class OnSiteDetailListWidget extends StatefulWidget {
  const OnSiteDetailListWidget({super.key});

  @override
  State<OnSiteDetailListWidget> createState() =>
      _OnSiteDetailListWidgetState();
}

class _OnSiteDetailListWidgetState extends State<OnSiteDetailListWidget> {
  late OnSiteDetailListModel _model;

  @override
  void initState() {
    super.initState();
    _model = OnSiteDetailListModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
