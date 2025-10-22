import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/error/failures.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:h_r_optimistic_mobile/core/base/base_view_model.dart';

class AnnouncementViewModel extends BaseViewModel {
  final AnnouncementRepository _repository;
  List<Announcement> _announcements = [];
  String? _errorMessage;
  bool _isLoading = false;

  AnnouncementViewModel({
    required AnnouncementRepository repository,
  }) : _repository = repository;

  List<Announcement> get announcements => _announcements;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  @override
  void initState(BuildContext context) {
    super.initState(context);
    fetchAnnouncements();
  }

  Future<void> fetchAnnouncements() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _repository.getAnnouncements();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
      },
      (announcements) {
        _announcements = announcements;
        _isLoading = false;
      },
    );
    notifyListeners();
  }

  Future<void> refreshAnnouncements() async {
    await fetchAnnouncements();
  }

  Future<void> markAsRead(String announcementId) async {
    final result = await _repository.markAnnouncementAsRead(announcementId);
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
      (_) {
        final index = _announcements.indexWhere((a) => a.id == announcementId);
        if (index != -1) {
          _announcements[index] = _announcements[index].copyWith(isRead: true);
          notifyListeners();
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred. Please try again later.';
      case NetworkFailure:
        return 'No internet connection. Please check your network.';
      case CacheFailure:
        return 'Cache error occurred. Please restart the app.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
