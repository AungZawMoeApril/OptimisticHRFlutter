import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/presentation/base/base_view.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/repositories/announcement_repository.dart';

class AnnouncementViewModel extends BaseViewModel {
  final AnnouncementRepository _repository;

  AnnouncementViewModel(this._repository);

  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  Future<void> loadAnnouncements() async {
    setBusy(true);
    final result = await _repository.getAnnouncements();
    result.fold(
      (failure) => setError(failure.message),
      (announcements) {
        _announcements = announcements;
        notifyListeners();
      },
    );
    setBusy(false);
  }

  Future<void> markAsRead(String id) async {
    final result = await _repository.markAsRead(id);
    result.fold(
      (failure) => setError(failure.message),
      (success) {
        if (success) {
          final index = _announcements.indexWhere((a) => a.id == id);
          if (index != -1) {
            _announcements[index] = _announcements[index].copyWith(isRead: true);
            notifyListeners();
          }
        }
      },
    );
  }

  Future<void> refreshAnnouncements() async {
    await loadAnnouncements();
  }
}