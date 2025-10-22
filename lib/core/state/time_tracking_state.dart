import 'base_state.dart';
import '../storage/secure_storage.dart';

/// Time tracking state model
class TimeTrackingState extends BaseState {
  final SecureStorageProvider _storage;
  
  String _clockInTime = '-';
  String _clockOutTime = '-';
  String _clockInLocation = '';
  String _clockOutLocation = '';
  String _clockInLatitude = '';
  String _clockInLongitude = '';
  String _clockOutLatitude = '';
  String _clockOutLongitude = '';
  int _timezoneOffset = 0;

  TimeTrackingState(this._storage);

  String get clockInTime => _clockInTime;
  String get clockOutTime => _clockOutTime;
  String get clockInLocation => _clockInLocation;
  String get clockOutLocation => _clockOutLocation;
  String get clockInLatitude => _clockInLatitude;
  String get clockInLongitude => _clockInLongitude;
  String get clockOutLatitude => _clockOutLatitude;
  String get clockOutLongitude => _clockOutLongitude;
  int get timezoneOffset => _timezoneOffset;

  @override
  Future<void> initialize() async {
    _clockInTime = await _storage.getValue('time_clock_in_time', '-') ?? '-';
    _clockOutTime = await _storage.getValue('time_clock_out_time', '-') ?? '-';
    _clockInLocation = await _storage.getValue('time_clock_in_location', '') ?? '';
    _clockOutLocation = await _storage.getValue('time_clock_out_location', '') ?? '';
    _clockInLatitude = await _storage.getValue('time_clock_in_latitude', '') ?? '';
    _clockInLongitude = await _storage.getValue('time_clock_in_longitude', '') ?? '';
    _clockOutLatitude = await _storage.getValue('time_clock_out_latitude', '') ?? '';
    _clockOutLongitude = await _storage.getValue('time_clock_out_longitude', '') ?? '';
    _timezoneOffset = await _storage.getValue('time_timezone_offset', 0) ?? 0;
    markInitialized();
  }

  Future<void> updateClockIn({
    required String time,
    required String location,
    required String latitude,
    required String longitude,
  }) async {
    _clockInTime = time;
    _clockInLocation = location;
    _clockInLatitude = latitude;
    _clockInLongitude = longitude;

    await Future.wait([
      _storage.setValue('time_clock_in_time', time),
      _storage.setValue('time_clock_in_location', location),
      _storage.setValue('time_clock_in_latitude', latitude),
      _storage.setValue('time_clock_in_longitude', longitude),
    ]);
    notifyListeners();
  }

  Future<void> updateClockOut({
    required String time,
    required String location,
    required String latitude,
    required String longitude,
  }) async {
    _clockOutTime = time;
    _clockOutLocation = location;
    _clockOutLatitude = latitude;
    _clockOutLongitude = longitude;

    await Future.wait([
      _storage.setValue('time_clock_out_time', time),
      _storage.setValue('time_clock_out_location', location),
      _storage.setValue('time_clock_out_latitude', latitude),
      _storage.setValue('time_clock_out_longitude', longitude),
    ]);
    notifyListeners();
  }

  Future<void> updateTimezoneOffset(int offset) async {
    if (offset != _timezoneOffset) {
      _timezoneOffset = offset;
      await _storage.setValue('time_timezone_offset', offset);
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _clockInTime = '-';
    _clockOutTime = '-';
    _clockInLocation = '';
    _clockOutLocation = '';
    _clockInLatitude = '';
    _clockInLongitude = '';
    _clockOutLatitude = '';
    _clockOutLongitude = '';
    _timezoneOffset = 0;
    notifyListeners();
  }
}