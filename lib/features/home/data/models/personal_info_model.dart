import '../../domain/entities/personal_info.dart';
import '/backend/api_requests/api_calls.dart';
import 'package:hr_app/core/utils/app_utils.dart';

class PersonalInfoModel extends PersonalInfo {
  PersonalInfoModel({
    required String prefix,
    required String email, 
    required String departmentName,
    required String mobile,
    required String hiredDate,
    required String nickname,
  }) : super(
          prefix: prefix,
          email: email,
          departmentName: departmentName, 
          mobile: mobile,
          hiredDate: hiredDate,
          nickname: nickname,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': [{
        'prefix': prefix,
        'email': email,
        'departmentName': departmentName,
        'mobile': mobile,
        'hiredDate': hiredDate,
        'nickname': nickname,
      }]
    };
  }
}