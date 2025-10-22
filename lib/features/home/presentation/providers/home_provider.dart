import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/personal_info.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/attendance_status.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../backend/api_requests/api_calls.dart' as api;
import '../../../../core/utilities/functions.dart' as functions;
import '../../../../core/state/app_state.dart';
import '../../../../core/state/notifiers/auth_state_notifier.dart';
import '../../../../core/state/notifiers/profile_state_notifier.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository _repository;
  final BuildContext context;

  HomeProvider(this._repository, this.context);

  AuthStateNotifier get _auth => context.read<AppState>().auth;
  ProfileStateNotifier get _profile => context.read<AppState>().profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCheckingInOut = false;
  bool get isCheckingInOut => _isCheckingInOut;

  String? _error;
  String? get error => _error;

  PersonalInfo? _personalInfo;
  PersonalInfo? get personalInfo => _personalInfo;

  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  int _notificationCount = 0;
  int get notificationCount => _notificationCount;

  bool _isPinCodeVerified = false;
  bool get isPinCodeVerified => _isPinCodeVerified;

  AttendanceStatus? _attendanceStatus;
  AttendanceStatus? get attendanceStatus => _attendanceStatus;

  Future<void> loadHomeData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.wait([
        _loadPersonalInfo(),
        _loadAttendanceStatus(),
        _loadNotifications(),
        _loadAnnouncements(),
      ]);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadPersonalInfo() async {
    final result = await api.MainGroup.getPersonalInfoCall.call(
      companyIDMain: int.tryParse(_auth.companyId ?? ''),
      employeeIDMain: int.tryParse(_auth.employeeId ?? ''),
      token: _auth.token,
      todayDateMain: functions.dateFormatToDay(),
    );

    if (result.succeeded && api.MainGroup.getPersonalInfoCall.apiStatus(result.jsonBody) == 0) {
      _personalInfo = PersonalInfo(
        prefix: api.MainGroup.getPersonalInfoCall.prefix(result.jsonBody) ?? '',
        email: api.MainGroup.getPersonalInfoCall.email(result.jsonBody) ?? '',
        departmentName: api.MainGroup.getPersonalInfoCall.departmentName(result.jsonBody) ?? '',
        mobile: api.MainGroup.getPersonalInfoCall.mobile(result.jsonBody) ?? '',
        hiredDate: api.MainGroup.getPersonalInfoCall.hiredDate(result.jsonBody) ?? '',
        nickname: api.MainGroup.getPersonalInfoCall.nickname(result.jsonBody) ?? '',
      );
      
      // Update app state for compatibility
      AppState().prefix = _personalInfo!.prefix;
      AppState().email = _personalInfo!.email;
      AppState().departmentName = _personalInfo!.departmentName;
      AppState().phone = _personalInfo!.mobile;
      AppState().hiredDate = _personalInfo!.hiredDate;
      AppState().nickName = _personalInfo!.nickname;
    } else {
      throw Exception('Failed to load personal info');
    }
  }

  Future<void> checkInOut({
    required bool isCheckIn,
    required double latitude,
    required double longitude,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await api.MainGroup.doCheckInOutAttendanceCall.call(
        isCheckIn: isCheckIn,
        latitude: latitude,
        longitude: longitude,
        token: AppState().token,
        companyID: AppState().companyID,
        employeeID: AppState().employeeID,
      );

      if (result.succeeded) {
        await _loadAttendanceStatus();
      } else {
        _error = result.jsonBody['message'] ?? 'Check in/out failed';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadAttendanceStatus() async {
    final result = await api.MainGroup.getDayViewOfSTACall.call(
      token: AppState().token,
      companyID: AppState().companyID,
      employeeID: AppState().employeeID,
      todayDate: functions.dateFormatToDay(),
    );

    if (result.succeeded && api.MainGroup.getDayViewOfSTACall.status(result.jsonBody) == 0) {
      final clockIn = api.MainGroup.getDayViewOfSTACall.latestCheckIN(result.jsonBody) ?? '-';
      final clockOut = api.MainGroup.getDayViewOfSTACall.lastestCheckOut(result.jsonBody) ?? '-';
      final startTime = api.MainGroup.getDayViewOfSTACall.startTime(result.jsonBody) ?? '';
      final endTime = api.MainGroup.getDayViewOfSTACall.endTime(result.jsonBody) ?? '';

      _attendanceStatus = AttendanceStatus(
        clockInTime: clockIn == '-' ? '-' : functions.changeCheckInOutTimeFormatFunction(clockIn)!,
        clockOutTime: clockOut == '-' ? '-' : functions.changeCheckInOutTimeFormatFunction(clockOut)!,
        shiftStartTime: startTime,
        shiftEndTime: endTime,
        timeType: AppState().timeType,
        canCheckIn: clockIn == '-' || clockOut != '-',
        approve: api.MainGroup.getDayViewOfSTACall.approve(result.jsonBody) ?? false,
      );
    } else {
      throw Exception('Failed to load attendance status');
    }
  }

  Future<void> _loadNotifications() async {
    final result = await api.MainGroup.apiLatestNotificationPOSTCall.call(
      companyID: AppState().companyID,
      receiverID: AppState().employeeID,
      token: AppState().token,
    );

    if (result.succeeded) {
      _notificationCount = api.MainGroup.apiLatestNotificationPOSTCall
          .notificationList(result.jsonBody)!
          .where((e) => 'true' == (e['seen'] ?? '').toString())
          .length;
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> _loadAnnouncements() async {
    final result = await api.MainGroup.getCustomerWebCall.call(
      timezoneOffset: AppState().timezoneOffset,
      token: AppState().token,
      companyID: AppState().companyID,
      employeeID: AppState().employeeID,
      perpage: 100,
      page: 100,
      searchValue: 'Announcement',
    );

    if (result.succeeded) {
      _announcements = api.MainGroup.getCustomerWebCall
          .announcementList(result.jsonBody)!
          .map((data) => Announcement.fromMap(data))
          .toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }

  Future<void> checkInOrOut() async {
    if (_attendanceStatus == null || !_attendanceStatus!.canCheckIn) return;
    if (_isCheckingInOut) return;

    _isCheckingInOut = true;
    _error = null;
    notifyListeners();

    try {
      final position = await _getCurrentPosition();
      if (position == null) {
        throw Exception('Location is required for attendance');
      }

      final isCheckIn = _attendanceStatus!.clockInTime == '-';
      await checkInOut(
        isCheckIn: isCheckIn,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // Navigate to appropriate screen after successful check in/out
      if (isCheckIn) {
        AppRouter.router.push('/home/check-in');
      } else {
        AppRouter.router.push('/home/check-out');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isCheckingInOut = false;
      notifyListeners();
    }
  }

  Future<Position?> _getCurrentPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _error = 'Location services are disabled';
        return null;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = 'Location permissions are denied';
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = 'Location permissions are permanently denied';
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      _error = 'Error getting location: $e';
      return null;
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}