import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/announcement_bloc.dart';
import '../bloc/announcement_event.dart';

class SearchAnnouncementsDialog extends StatefulWidget {
  const SearchAnnouncementsDialog({super.key});

  @override
  State<SearchAnnouncementsDialog> createState() => _SearchAnnouncementsDialogState();
}

class _SearchAnnouncementsDialogState extends State<SearchAnnouncementsDialog> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Announcements'),
      content: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Enter search term',
          prefixIcon: Icon(Icons.search),
        ),
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            context.read<AnnouncementBloc>().add(SearchAnnouncements(query));
            Navigator.pop(context);
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final query = _searchController.text.trim();
            if (query.isNotEmpty) {
              context.read<AnnouncementBloc>().add(SearchAnnouncements(query));
              Navigator.pop(context);
            }
          },
          child: const Text('Search'),
        ),
      ],
    );
  }
}