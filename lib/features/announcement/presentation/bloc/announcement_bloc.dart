/// Stub bloc for announcements - flutter_bloc package not available
import 'announcement_event.dart';
import 'announcement_state.dart';

/// Stub implementation of AnnouncementBloc
/// The actual bloc implementation requires flutter_bloc package
class AnnouncementBloc {
  AnnouncementState _state = AnnouncementInitial();

  AnnouncementState get state => _state;

  AnnouncementBloc(dynamic repository);

  void add(AnnouncementEvent event) {
    // Stub implementation
  }

  Stream<AnnouncementState> get stream => Stream.value(_state);

  void close() {
    // Stub implementation
  }
}
