import 'package:equatable/equatable.dart';
import '../../domain/entities/announcement.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object?> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementError extends AnnouncementState {
  final String message;

  const AnnouncementError(this.message);

  @override
  List<Object?> get props => [message];
}

class AnnouncementsLoaded extends AnnouncementState {
  final List<Announcement> announcements;
  final List<Announcement> filteredAnnouncements;
  final String searchQuery;

  const AnnouncementsLoaded(
    this.announcements, {
    this.filteredAnnouncements = const [],
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [announcements, filteredAnnouncements, searchQuery];

  AnnouncementsLoaded copyWith({
    List<Announcement>? announcements,
    List<Announcement>? filteredAnnouncements,
    String? searchQuery,
  }) {
    return AnnouncementsLoaded(
      announcements ?? this.announcements,
      filteredAnnouncements: filteredAnnouncements ?? this.filteredAnnouncements,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Announcement> get displayAnnouncements =>
      searchQuery.isEmpty ? announcements : filteredAnnouncements;
}

class AnnouncementRead extends AnnouncementState {
  final String announcementId;

  const AnnouncementRead(this.announcementId);

  @override
  List<Object?> get props => [announcementId];
}