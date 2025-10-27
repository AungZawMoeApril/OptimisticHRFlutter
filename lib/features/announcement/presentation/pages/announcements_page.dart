import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h_r_optimistic_mobile/features/announcement/presentation/bloc/announcement_bloc.dart';
import 'package:h_r_optimistic_mobile/features/announcement/presentation/bloc/announcement_event.dart';
import 'package:h_r_optimistic_mobile/features/announcement/presentation/bloc/announcement_state.dart';
import 'package:h_r_optimistic_mobile/features/home/presentation/widgets/announcement_list.dart';
import '../widgets/search_announcements_dialog.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({super.key});

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SearchAnnouncementsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementBloc, AnnouncementState>(
      listener: (context, state) {
        if (state is AnnouncementError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Announcements'),
            actions: [
              IconButton(
                icon: Icon(
                  state is AnnouncementsLoaded && state.searchQuery.isNotEmpty
                      ? Icons.close
                      : Icons.search,
                ),
                onPressed: () {
                  if (state is AnnouncementsLoaded && state.searchQuery.isNotEmpty) {
                    context.read<AnnouncementBloc>().add(ClearSearch());
                  } else {
                    _showSearchDialog(context);
                  }
                },
              ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AnnouncementState state) {
    if (state is AnnouncementInitial) {
      // Load announcements when the page is first opened
      context.read<AnnouncementBloc>().add(LoadAnnouncements());
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AnnouncementLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AnnouncementsLoaded) {
      return AnnouncementList(
        announcements: state.displayAnnouncements,
        isLoading: false,
        onRefresh: () {
          context.read<AnnouncementBloc>().add(RefreshAnnouncements());
        },
        onAnnouncementTap: (id) {
          context.read<AnnouncementBloc>().add(MarkAnnouncementAsRead(id));
          // Navigate to announcement detail
          Navigator.pushNamed(
            context,
            '/announcement',
            arguments: state.announcements.firstWhere((a) => a.id == id),
          );
        },
      );
    }

    if (state is AnnouncementError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<AnnouncementBloc>().add(LoadAnnouncements());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}