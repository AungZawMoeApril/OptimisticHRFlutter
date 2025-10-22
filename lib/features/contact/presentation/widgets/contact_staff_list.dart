import 'package:flutter/material.dart';
import '../../domain/entities/contact_staff.dart';
import 'contact_staff_card.dart';

class ContactStaffList extends StatelessWidget {
  final List<ContactStaff> contacts;

  const ContactStaffList({
    super.key,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return ContactStaffCard(contact: contacts[index]);
      },
    );
  }
}