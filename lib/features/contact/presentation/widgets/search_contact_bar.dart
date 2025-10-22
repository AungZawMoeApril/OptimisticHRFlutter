import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contact_staff_provider.dart';

class SearchContactBar extends StatelessWidget {
  const SearchContactBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search staff...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (query) {
          if (query.isNotEmpty) {
            context.read<ContactStaffProvider>().searchContacts(query);
          }
        },
      ),
    );
  }
}