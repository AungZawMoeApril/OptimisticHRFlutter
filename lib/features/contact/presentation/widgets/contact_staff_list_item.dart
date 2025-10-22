import 'package:flutter/material.dart';
import '../../domain/entities/contact_staff.dart';

class ContactStaffListItem extends StatelessWidget {
  final ContactStaff staff;

  const ContactStaffListItem({
    super.key, 
    required this.staff,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(staff.imageUrl),
        radius: 25,
      ),
      title: Text(
        '${staff.prefix} ${staff.firstName} ${staff.lastName}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            staff.positionName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            staff.departmentName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.email),
            onPressed: () {
              // TODO: Launch email
            },
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // TODO: Launch phone call
            },
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      isThreeLine: true,
      dense: true,
      onTap: () {
        // TODO: Show staff details
      },
    );
  }
}