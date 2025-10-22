import 'package:flutter/material.dart';
import '../../domain/entities/contact_staff.dart';

class ContactStaffCard extends StatelessWidget {
  final ContactStaff contact;

  const ContactStaffCard({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: contact.photoUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(contact.photoUrl!),
              )
            : CircleAvatar(
                child: Text(contact.name[0].toUpperCase()),
              ),
        title: Text(contact.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.position),
            Text(contact.department),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: () {
                // TODO: Implement email action
              },
            ),
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                // TODO: Implement phone action
              },
            ),
          ],
        ),
      ),
    );
  }
}