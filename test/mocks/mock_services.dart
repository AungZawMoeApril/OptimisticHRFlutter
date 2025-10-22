import 'package:mockito/mockito.dart';
import 'package:hr_app/core/services/auth_service.dart';
import 'package:hr_app/core/services/leave_service.dart';
import 'package:hr_app/core/services/attendance_service.dart';
import '../mocks/mock_data.dart';

class MockAuthService extends Mock implements AuthService {
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    return MockData.mockApiResponses['login'];
  }

  @override
  Future<void> logout() async {
    return;
  }
}

class MockLeaveService extends Mock implements LeaveService {
  @override
  Future<Map<String, dynamic>> submitLeaveRequest(Map<String, dynamic> request) async {
    return MockData.mockApiResponses['leave_request'];
  }

  @override
  Future<List<Map<String, dynamic>>> getLeaveRequests() async {
    return MockData.leaveRequests.map((lr) => lr.toJson()).toList();
  }
}

class MockAttendanceService extends Mock implements AttendanceService {
  @override
  Future<Map<String, dynamic>> checkIn(Map<String, dynamic> data) async {
    return MockData.mockApiResponses['attendance'];
  }

  @override
  Future<Map<String, dynamic>> checkOut(Map<String, dynamic> data) async {
    return MockData.mockApiResponses['attendance'];
  }

  @override
  Future<List<Map<String, dynamic>>> getAttendanceHistory() async {
    return MockData.attendanceRecords.map((ar) => ar.toJson()).toList();
  }
}