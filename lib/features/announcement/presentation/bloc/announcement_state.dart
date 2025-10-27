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

  const AnnouncementsLoaded(this.announcements);

  @override
  List<Object?> get props => [announcements];
}

class AnnouncementRead extends AnnouncementState {
  final String announcementId;

  const AnnouncementRead(this.announcementId);

  @override
  List<Object?> get props => [announcementId];
}