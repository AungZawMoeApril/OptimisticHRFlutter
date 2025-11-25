class PersonalInfo {
  final String prefix;
  final String email;
  final String departmentName;
  final String mobile;
  final String hiredDate;
  final String nickname;
  final String employeeImage;
  final String employeeName;
  final String department;
  final String position;
  final int totalLeaveRemain;

  PersonalInfo({
    required this.prefix,
    required this.email,
    required this.departmentName,
    required this.mobile,
    required this.hiredDate,
    required this.nickname,
    this.employeeImage = '',
    this.employeeName = '',
    this.department = '',
    this.position = '',
    this.totalLeaveRemain = 0,
  });
}