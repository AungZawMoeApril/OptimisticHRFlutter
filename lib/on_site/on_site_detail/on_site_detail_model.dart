import 'package:flutter/material.dart';
import '../../core/presentation/base/base_view.dart';

class OnSiteDetailModel extends BaseViewModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex => tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex => tabBarController != null ? tabBarController!.previousIndex : 0;

  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    super.dispose();
  }
}
