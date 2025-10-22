import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../backend/api_requests/api_calls.dart';
import '../providers/contact_staff_provider.dart';
import '../widgets/contact_staff_list_item.dart';

class ContactStaffPage extends StatefulWidget {
  const ContactStaffPage({super.key});

  static String routeName = 'ContactStaff';
  static String routePath = '/contactStaff';

  @override
  State<ContactStaffPage> createState() => _ContactStaffPageState();
}

class _ContactStaffPageState extends State<ContactStaffPage> {
  late final TextEditingController _searchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Load data on page init
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ContactStaffProvider>().loadContactStaffList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactStaffProvider = context.watch<ContactStaffProvider>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            automaticallyImplyLeading: false,
            leading: CustomIconButton(
              borderRadius: 30,
              buttonSize: 46,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Contact Staff',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      EasyDebounce.debounce(
                        '_searchController',
                        const Duration(milliseconds: 500),
                        () => contactStaffProvider.searchStaff(value),
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Search staff...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: contactStaffProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : contactStaffProvider.error != null
                          ? Center(child: Text(contactStaffProvider.error!))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: contactStaffProvider.filteredStaff.length,
                              itemBuilder: (context, index) {
                                final staff = contactStaffProvider.filteredStaff[index];
                                return ContactStaffListItem(staff: staff);
                              },
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