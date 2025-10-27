import 'package:equatable/equatable.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnnouncements extends AnnouncementEvent {}

class RefreshAnnouncements extends AnnouncementEvent {}

class MarkAnnouncementAsRead extends AnnouncementEvent {
  final String announcementId;

  const MarkAnnouncementAsRead(this.announcementId);

  @override
  List<Object?> get props => [announcementId];
}

class ClearAnnouncementError extends AnnouncementEvent {}

class SearchAnnouncements extends AnnouncementEvent {
  final String query;

  const SearchAnnouncements(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends AnnouncementEvent {}