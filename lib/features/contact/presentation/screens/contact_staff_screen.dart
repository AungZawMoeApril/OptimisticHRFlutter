import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contact_staff_provider.dart';
import '../widgets/contact_staff_list.dart';
import '../widgets/search_contact_bar.dart';
import '../../../../core/theme/app_theme.dart';

class ContactStaffScreen extends StatelessWidget {
  const ContactStaffScreen({super.key});

  static const String routeName = '/contact-staff';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Staff'),
      ),
      body: Column(
        children: [
          const SearchContactBar(),
          Expanded(
            child: Consumer<ContactStaffProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error.isNotEmpty) {
                  return Center(child: Text(provider.error));
                }

                if (provider.contacts.isEmpty) {
                  return const Center(child: Text('No contacts found'));
                }

                return ContactStaffList(contacts: provider.contacts);
              },
            ),
          ),
        ],
      ),
    );
  }
}