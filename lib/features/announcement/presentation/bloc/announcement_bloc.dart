import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/announcement_repository.dart';
import '../../../core/error/failures.dart';
import 'announcement_event.dart';
import 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository _repository;

  AnnouncementBloc(this._repository) : super(AnnouncementInitial()) {
    on<LoadAnnouncements>(_onLoadAnnouncements);
    on<RefreshAnnouncements>(_onRefreshAnnouncements);
    on<MarkAnnouncementAsRead>(_onMarkAnnouncementAsRead);
    on<ClearAnnouncementError>(_onClearError);
    on<SearchAnnouncements>(_onSearchAnnouncements);
    on<ClearSearch>(_onClearSearch);
  }

  void _onSearchAnnouncements(
    SearchAnnouncements event,
    Emitter<AnnouncementState> emit,
  ) {
    if (state is AnnouncementsLoaded) {
      final currentState = state as AnnouncementsLoaded;
      final query = event.query.toLowerCase();
      
      final filteredAnnouncements = currentState.announcements
          .where((announcement) =>
              announcement.title.toLowerCase().contains(query) ||
              announcement.description.toLowerCase().contains(query))
          .toList();
      
      emit(currentState.copyWith(
        filteredAnnouncements: filteredAnnouncements,
        searchQuery: query,
      ));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<AnnouncementState> emit,
  ) {
    if (state is AnnouncementsLoaded) {
      final currentState = state as AnnouncementsLoaded;
      emit(currentState.copyWith(
        filteredAnnouncements: const [],
        searchQuery: '',
      ));
    }
  }

  Future<void> _onLoadAnnouncements(
    LoadAnnouncements event,
    Emitter<AnnouncementState> emit,
  ) async {
    if (state is AnnouncementLoading) return;

    emit(AnnouncementLoading());

    final result = await _repository.getAnnouncements();
    emit(result.fold(
      (failure) => AnnouncementError(_mapFailureToMessage(failure)),
      (announcements) => AnnouncementsLoaded(announcements),
    ));
  }

  Future<void> _onRefreshAnnouncements(
    RefreshAnnouncements event,
    Emitter<AnnouncementState> emit,
  ) async {
    final result = await _repository.getAnnouncements();
    emit(result.fold(
      (failure) => AnnouncementError(_mapFailureToMessage(failure)),
      (announcements) => AnnouncementsLoaded(announcements),
    ));
  }

  Future<void> _onMarkAnnouncementAsRead(
    MarkAnnouncementAsRead event,
    Emitter<AnnouncementState> emit,
  ) async {
    final result = await _repository.markAnnouncementAsRead(event.announcementId);
    
    result.fold(
      (failure) => emit(AnnouncementError(_mapFailureToMessage(failure))),
      (_) async {
        emit(AnnouncementRead(event.announcementId));
        
        // Reload the announcements to update the list
        final announcementsResult = await _repository.getAnnouncements();
        emit(announcementsResult.fold(
          (failure) => AnnouncementError(_mapFailureToMessage(failure)),
          (announcements) => AnnouncementsLoaded(announcements),
        ));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      case NetworkFailure:
        return (failure as NetworkFailure).message;
      case ValidationFailure:
        return (failure as ValidationFailure).message;
      default:
        return 'Unexpected error occurred';
    }
  }

  void _onClearError(
    ClearAnnouncementError event,
    Emitter<AnnouncementState> emit,
  ) {
    if (state is AnnouncementError) {
      emit(AnnouncementInitial());
    }
  }
}