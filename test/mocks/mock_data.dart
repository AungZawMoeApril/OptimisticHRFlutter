import 'package:hr_app/core/models/leave_request.dart';
import 'package:hr_app/core/models/user.dart';
import 'package:hr_app/core/models/attendance.dart';

/// Mock data for testing
class MockData {
  static final User testUser = User(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    employeeId: 'EMP001',
    department: 'IT',
    position: 'Software Engineer',
    joinDate: DateTime(2023, 1, 1),
  );

  static final List<LeaveRequest> leaveRequests = [
    LeaveRequest(
      id: 1,
      employeeId: 'EMP001',
      type: 'Annual Leave',
      startDate: DateTime.now().add(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 8)),
      status: 'Pending',
      reason: 'Family vacation',
      requestedDate: DateTime.now(),
    ),
    LeaveRequest(
      id: 2,
      employeeId: 'EMP001',
      type: 'Sick Leave',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 4)),
      status: 'Approved',
      reason: 'Fever',
      requestedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  static final List<Attendance> attendanceRecords = [
    Attendance(
      id: 1,
      employeeId: 'EMP001',
      date: DateTime.now(),
      checkInTime: DateTime.now().subtract(const Duration(hours: 8)),
      checkOutTime: DateTime.now(),
      status: 'Present',
    ),
    Attendance(
      id: 2,
      employeeId: 'EMP001',
      date: DateTime.now().subtract(const Duration(days: 1)),
      checkInTime: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
      checkOutTime: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Present',
    ),
  ];

  static Map<String, dynamic> mockApiResponses = {
    'login': {
      'status': '0',
      'message': 'Login successful',
      'data': {
        'token': 'mock-token-123',
        'user': testUser.toJson(),
      },
    },
    'leave_request': {
      'status': '0',
      'message': 'Leave request submitted successfully',
      'data': leaveRequests[0].toJson(),
    },
    'attendance': {
      'status': '0',
      'message': 'Attendance recorded successfully',
      'data': attendanceRecords[0].toJson(),
    },
  };
}