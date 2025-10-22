import 'base_state_notifier.dart';
import '../../storage/storage_manager.dart' as storage_manager;

class TimeTrackingStateNotifier extends BaseStateNotifier {
  DateTime? _lastCheckIn;
  DateTime? _lastCheckOut;
  String? _currentLocation;
  bool _isCheckedIn = false;
  Map<String, dynamic>? _lastTimeRecord;

  TimeTrackingStateNotifier() : super(storage_manager.StorageManager.timeTrackingBox);

  DateTime? get lastCheckIn => _lastCheckIn;
  DateTime? get lastCheckOut => _lastCheckOut;
  String? get currentLocation => _currentLocation;
  bool get isCheckedIn => _isCheckedIn;
  Map<String, dynamic>? get lastTimeRecord => _lastTimeRecord;

  @override
  Future<void> loadState() async {
    final checkInStr = await getValue<String>('time_last_check_in');
    _lastCheckIn = checkInStr != null ? DateTime.tryParse(checkInStr) : null;

    final checkOutStr = await getValue<String>('time_last_check_out');
    _lastCheckOut = checkOutStr != null ? DateTime.tryParse(checkOutStr) : null;

    _currentLocation = await getValue('time_current_location');
    _isCheckedIn = (await getValue('time_is_checked_in')) ?? false;
    _lastTimeRecord = await getValue('time_last_record');
  }

  @override
  Future<void> saveState() async {
    await setValue('time_last_check_in', _lastCheckIn?.toIso8601String());
    await setValue('time_last_check_out', _lastCheckOut?.toIso8601String());
    await setValue('time_current_location', _currentLocation);
    await setValue('time_is_checked_in', _isCheckedIn);
    await setValue('time_last_record', _lastTimeRecord);
  }

  Future<void> checkIn({
    required DateTime time,
    required String location,
  }) async {
    _lastCheckIn = time;
    _currentLocation = location;
    _isCheckedIn = true;
    await saveState();
    notifyListeners();
  }

  Future<void> checkOut({
    required DateTime time,
    required String location,
    required Map<String, dynamic> timeRecord,
  }) async {
    _lastCheckOut = time;
    _currentLocation = location;
    _isCheckedIn = false;
    _lastTimeRecord = timeRecord;
    await saveState();
    notifyListeners();
  }

  Future<void> updateLocation(String location) async {
    if (location != _currentLocation) {
      _currentLocation = location;
      await saveState();
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _lastCheckIn = null;
    _lastCheckOut = null;
    _currentLocation = null;
    _isCheckedIn = false;
    _lastTimeRecord = null;
    await saveState();
    await super.clear();
  }
}