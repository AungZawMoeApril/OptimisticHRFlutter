import '../../domain/entities/personal_info.dart';

class PersonalInfoModel extends PersonalInfo {
  PersonalInfoModel({
    required String prefix,
    required String email,
    required String departmentName,
    required String mobile,
    required String hiredDate,
    required String nickname,
    String employeeImage = '',
    String employeeName = '',
    String department = '',
    String position = '',
    int totalLeaveRemain = 0,
  }) : super(
          prefix: prefix,
          email: email,
          departmentName: departmentName,
          mobile: mobile,
          hiredDate: hiredDate,
          nickname: nickname,
          employeeImage: employeeImage,
          employeeName: employeeName,
          department: department,
          position: position,
          totalLeaveRemain: totalLeaveRemain,
        );

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as List).first;
    return PersonalInfoModel(
      prefix: data['prefix'] ?? '',
      email: data['email'] ?? '',
      departmentName: data['departmentName'] ?? '',
      mobile: data['mobile'] ?? '',
      hiredDate: data['hiredDate'] ?? '',
      nickname: data['nickname'] ?? '',
      employeeImage: data['employeeImage'] ?? '',
      employeeName: data['employeeName'] ?? '',
      department: data['department'] ?? '',
      position: data['position'] ?? '',
      totalLeaveRemain: data['totalLeaveRemain'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': [
        {
          'prefix': prefix,
          'email': email,
          'departmentName': departmentName,
          'mobile': mobile,
          'hiredDate': hiredDate,
          'nickname': nickname,
          'employeeImage': employeeImage,
          'employeeName': employeeName,
          'department': department,
          'position': position,
          'totalLeaveRemain': totalLeaveRemain,
        }
      ]
    };
  }
}
