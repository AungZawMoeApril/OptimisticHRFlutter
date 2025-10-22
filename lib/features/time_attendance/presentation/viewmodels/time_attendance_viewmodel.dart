import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/presentation/base/base_view.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/domain/entities/attendance_record.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/domain/repositories/time_attendance_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class TimeAttendanceViewModel extends BaseViewModel {
  final TimeAttendanceRepository _repository;
  
  TimeAttendanceViewModel(this._repository);

  AttendanceRecord? _todayAttendance;
  AttendanceRecord? get todayAttendance => _todayAttendance;

  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  XFile? _checkInImage;
  XFile? get checkInImage => _checkInImage;

  XFile? _checkOutImage;
  XFile? get checkOutImage => _checkOutImage;

  Future<void> loadTodayAttendance(String userId) async {
    setBusy(true);
    final result = await _repository.getTodayAttendance(userId);
    result.fold(
      (failure) => setError(failure.message),
      (attendance) {
        _todayAttendance = attendance;
        notifyListeners();
      },
    );
    setBusy(false);
  }

  Future<void> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentPosition = position;
      notifyListeners();
    } catch (e) {
      setError('Could not get current location. Please enable GPS and try again.');
    }
  }

  Future<void> pickImage(bool isCheckIn) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image != null) {
        if (isCheckIn) {
          _checkInImage = image;
        } else {
          _checkOutImage = image;
        }
        notifyListeners();
      }
    } catch (e) {
      setError('Could not access camera. Please try again.');
    }
  }

  Future<void> checkIn(String userId) async {
    if (_currentPosition == null) {
      setError('Please enable location services and try again.');
      return;
    }

    setBusy(true);
    final result = await _repository.checkIn(
      userId: userId,
      location: 'Current Location', // TODO: Implement reverse geocoding
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
      checkInImage: _checkInImage?.path,
    );

    result.fold(
      (failure) => setError(failure.message),
      (attendance) {
        _todayAttendance = attendance;
        _checkInImage = null;
        notifyListeners();
      },
    );
    setBusy(false);
  }

  Future<void> checkOut(String userId) async {
    if (_currentPosition == null) {
      setError('Please enable location services and try again.');
      return;
    }

    setBusy(true);
    final result = await _repository.checkOut(
      userId: userId,
      location: 'Current Location', // TODO: Implement reverse geocoding
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
      checkOutImage: _checkOutImage?.path,
    );

    result.fold(
      (failure) => setError(failure.message),
      (attendance) {
        _todayAttendance = attendance;
        _checkOutImage = null;
        notifyListeners();
      },
    );
    setBusy(false);
  }
}