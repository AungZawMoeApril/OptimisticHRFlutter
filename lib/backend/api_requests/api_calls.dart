import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../core/utils/app_utils.dart';;
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start main Group Code

class MainGroup {
  static String getBaseUrl({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) =>
      'https://optimisticwebapis-dotnet8-eaapgpcndtaeeud4.southeastasia-01.azurewebsites.net';
  static Map<String, String> headers = {
    'authorization': 'Bearer [token]',
  };
  static LoginCall loginCall = LoginCall();
  static ApiLoginForgetPasswordPOSTCall apiLoginForgetPasswordPOSTCall =
      ApiLoginForgetPasswordPOSTCall();
  static DeleteOTRequestCall deleteOTRequestCall = DeleteOTRequestCall();
  static ApiLatestNotificationPOSTCall apiLatestNotificationPOSTCall =
      ApiLatestNotificationPOSTCall();
  static ApiContactStaffPostCall apiContactStaffPostCall =
      ApiContactStaffPostCall();
  static GetLeaveWithRemainingDaysCall getLeaveWithRemainingDaysCall =
      GetLeaveWithRemainingDaysCall();
  static ApiLeaveHistoryPOSTCall apiLeaveHistoryPOSTCall =
      ApiLeaveHistoryPOSTCall();
  static GetOTandTimeOffCall getOTandTimeOffCall = GetOTandTimeOffCall();
  static ApiOvertimeHistoryPOSTCall apiOvertimeHistoryPOSTCall =
      ApiOvertimeHistoryPOSTCall();
  static ApiOvertimePendingPOSTCall apiOvertimePendingPOSTCall =
      ApiOvertimePendingPOSTCall();
  static ApiDropDownOvertimeMenuPOSTCall apiDropDownOvertimeMenuPOSTCall =
      ApiDropDownOvertimeMenuPOSTCall();
  static GetTimeEntriesByEmployeeIDAndTimeCall
      getTimeEntriesByEmployeeIDAndTimeCall =
      GetTimeEntriesByEmployeeIDAndTimeCall();
  static ApiOnSitePOSTCall apiOnSitePOSTCall = ApiOnSitePOSTCall();
  static ApiAllLeavePOSTCall apiAllLeavePOSTCall = ApiAllLeavePOSTCall();
  static PaySlipCall paySlipCall = PaySlipCall();
  static AddTimeOffRequestForEMPWholeDayCall
      addTimeOffRequestForEMPWholeDayCall =
      AddTimeOffRequestForEMPWholeDayCall();
  static AddTimeOffRequestForEMPHalfDayCall addTimeOffRequestForEMPHalfDayCall =
      AddTimeOffRequestForEMPHalfDayCall();
  static ApiTimeAttendanceDayViewPOSTCall apiTimeAttendanceDayViewPOSTCall =
      ApiTimeAttendanceDayViewPOSTCall();
  static AddClockInOutCall addClockInOutCall = AddClockInOutCall();
  static ApiCheckOutPOSTCall apiCheckOutPOSTCall = ApiCheckOutPOSTCall();
  static ApiLeaveRequestHalfDayPOSTCall apiLeaveRequestHalfDayPOSTCall =
      ApiLeaveRequestHalfDayPOSTCall();
  static UpdateStatusMyApprovalCall updateStatusMyApprovalCall =
      UpdateStatusMyApprovalCall();
  static GetDayViewOfSTACall getDayViewOfSTACall = GetDayViewOfSTACall();
  static UpdateClockInOutCall updateClockInOutCall = UpdateClockInOutCall();
  static GetTimeOffRequestByCompanyIdCall getTimeOffRequestByCompanyIdCall =
      GetTimeOffRequestByCompanyIdCall();
  static GetCustomerWebCall getCustomerWebCall = GetCustomerWebCall();
  static GetAnnouncementByIdCall getAnnouncementByIdCall =
      GetAnnouncementByIdCall();
  static GetPersonalInfoCall getPersonalInfoCall = GetPersonalInfoCall();
  static UpdatePersonalInfoMobCall updatePersonalInfoMobCall =
      UpdatePersonalInfoMobCall();
  static GetTimeOffRequestByCompanyIdPaginationCall
      getTimeOffRequestByCompanyIdPaginationCall =
      GetTimeOffRequestByCompanyIdPaginationCall();
  static ChangePasswordCall changePasswordCall = ChangePasswordCall();
  static GetPersonalInfoForMobCall getPersonalInfoForMobCall =
      GetPersonalInfoForMobCall();
  static StaffOTRequestCall staffOTRequestCall = StaffOTRequestCall();
  static GetAllLocationsByCompanyIDCall getAllLocationsByCompanyIDCall =
      GetAllLocationsByCompanyIDCall();
  static GetDefaultSettingCall getDefaultSettingCall = GetDefaultSettingCall();
  static AddClockInOutMobileCall addClockInOutMobileCall =
      AddClockInOutMobileCall();
  static GetTimeAttendanceListMobileCall getTimeAttendanceListMobileCall =
      GetTimeAttendanceListMobileCall();
  static UpdateClockInOutMobileCall updateClockInOutMobileCall =
      UpdateClockInOutMobileCall();
  static GetPersonalInfoByCompanyIDCall getPersonalInfoByCompanyIDCall =
      GetPersonalInfoByCompanyIDCall();
  static GetOTRequestByStatusMobileCall getOTRequestByStatusMobileCall =
      GetOTRequestByStatusMobileCall();
  static OTCheckkOutMobileCall oTCheckkOutMobileCall = OTCheckkOutMobileCall();
  static GetOTDetailForCheckInOutMobileCall getOTDetailForCheckInOutMobileCall =
      GetOTDetailForCheckInOutMobileCall();
  static GetCurrentOTMobileCall getCurrentOTMobileCall =
      GetCurrentOTMobileCall();
  static GetOTRequestForspecificPaginationCall
      getOTRequestForspecificPaginationCall =
      GetOTRequestForspecificPaginationCall();
  static GetOTandTimeOffMobileCall getOTandTimeOffMobileCall =
      GetOTandTimeOffMobileCall();
  static UpdateTimeOffRequestCall updateTimeOffRequestCall =
      UpdateTimeOffRequestCall();
  static ForgetPasswordCall forgetPasswordCall = ForgetPasswordCall();
  static UpdateOTRequestCall updateOTRequestCall = UpdateOTRequestCall();
  static OTRequestCall oTRequestCall = OTRequestCall();
  static UpdateLeaveRequestCall updateLeaveRequestCall =
      UpdateLeaveRequestCall();
  static DeleteOTRequestsCall deleteOTRequestsCall = DeleteOTRequestsCall();
  static DeleteTimeOffCall deleteTimeOffCall = DeleteTimeOffCall();
  static OTCheckInMobileCall oTCheckInMobileCall = OTCheckInMobileCall();
  static OvertimeListViewCall overtimeListViewCall = OvertimeListViewCall();
  static GetworkFlowOfOTRequestCall getworkFlowOfOTRequestCall =
      GetworkFlowOfOTRequestCall();
  static AddNotificationInfoMobCall addNotificationInfoMobCall =
      AddNotificationInfoMobCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? companyCode = '',
    String? username = '',
    String? password = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "companyCode": "${companyCode}",
  "username": "${username}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${baseUrl}/api/v1/LoginInfo/Login',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? userID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.user_ID''',
      ));
  String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.firstName''',
      ));
  String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.username''',
      ));
  String? country(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.country''',
      ));
  String? createDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.createDate''',
      ));
  int? createBy(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.createBy''',
      ));
  bool? activeFlag(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.activeFlag''',
      ));
  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.token''',
      ));
  int? companyID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.company_ID''',
      ));
  int? roleID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.role_ID''',
      ));
  int? positionID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.positionID''',
      ));
  int? reportID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.report_ID''',
      ));
  int? firstUserID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.firstUserID''',
      ));
  String? roleName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.role_Name''',
      ));
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.image''',
      ));
  int? employeeID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.employee_ID''',
      ));
  String? employeeCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.employee_Code''',
      ));
  bool? isLocked(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.is_Locked''',
      ));
  String? companyCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.company_Code''',
      ));
  String? expireDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.expire_Date''',
      ));
  bool? dataStatus(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.status''',
      ));
  int? consentID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.consentID''',
      ));
  int? employeeStatus(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.employeeStatus''',
      ));
  String? logoImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.logoImage''',
      ));
  String? colorCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.color_Code''',
      ));
  String? flag(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.flag''',
      ));
  bool? timeAttendance(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.time_Attendance''',
      ));
  String? positionName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.position_Name''',
      ));
  String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.lastName''',
      ));
  int? reportID2(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.report_ID2''',
      ));
  int? reportID3(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.report_ID3''',
      ));
  int? reportID4(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.report_ID4''',
      ));
  int? reportID5(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.report_ID5''',
      ));
}

class ApiLoginForgetPasswordPOSTCall {
  Future<ApiCallResponse> call({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_Id": 0,
  "company_Code": "",
  "user_Id": 0
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiLoginForgetPassword POST',
      apiUrl: '${baseUrl}/api/v1/LoginInfo/ForgetPassword',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteOTRequestCall {
  Future<ApiCallResponse> call({
    int? oTRequestID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'DeleteOTRequest',
      apiUrl: '${baseUrl}/api/v1/OT_Request/DeleteOT_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiLatestNotificationPOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? receiverID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "receiver_ID": ${receiverID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiLatestNotification POST',
      apiUrl: '${baseUrl}/api/v1/NotificationInfo/GetLatestNoti',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? notificationList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ApiContactStaffPostCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiContactStaff Post',
      apiUrl: '${baseUrl}/api/PersonalInfo/GetPersonalInfowithlist',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic contactStaffList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class GetLeaveWithRemainingDaysCall {
  Future<ApiCallResponse> call({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyIDMain},
  "employee_ID": ${employeeIDMain}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetLeaveWithRemainingDays',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/GetLeaveWithRemainingDays',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<int>? timeOffIDList(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].timeOff_ID''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? approverIDList(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].approver_ID''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? leaveMenuList(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].timeoff_TypeEN''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? leaveTypeList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? leaveDaysLeft(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].leaveDaysLeft''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  int? availableDays(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].availablDays''',
      ));
}

class ApiLeaveHistoryPOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    int? requesterID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "employee_ID": ${employeeID},
  "requester_ID": ${requesterID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiLeaveHistory POST',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/GetTimeOff_RequestForHr',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? leaveHistoryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetOTandTimeOffCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "employee_ID": ${employeeID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetOTandTimeOff',
      apiUrl: '${baseUrl}/api/v1/MyTasks/Get_OTandTimeOff',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? myApprovalList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<int>? workFlowID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].wF_ID''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? workFlowName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].workFlow_Name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? approverOrder(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].approverOrder''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class ApiOvertimeHistoryPOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiOvertimeHistory POST',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetHROT_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? overtimeHistoryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? overtimestatus(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  int? outputstatus(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class ApiOvertimePendingPOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    int? monthNum,
    int? yearNum,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "month_Num": ${monthNum},
  "year_Num": ${yearNum},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiOvertimePending POST',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetOT_RequestForspecific',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? overtimePendingList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ApiDropDownOvertimeMenuPOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiDropDownOvertimeMenu POST',
      apiUrl: '${baseUrl}/api/v1/OTSetting/GetOTSetting',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTimeEntriesByEmployeeIDAndTimeCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    int? monthNum,
    int? yearNum,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "employee_ID": ${employeeID},
  "month_Num": ${monthNum},
  "year_Num": ${yearNum}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetTimeEntriesByEmployeeIDAndTime',
      apiUrl: '${baseUrl}/api/v1/TimeEntries/GetTimeEntriesByEmployeeIDAndTime',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? timeAttendaceMonthView(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List? timeAttendanceRegular(dynamic response) => getJsonField(
        response,
        r'''$.data[:].regCinoutData''',
        true,
      ) as List?;
  List? timeAttendanceIrregular(dynamic response) => getJsonField(
        response,
        r'''$.data[:].irregularRegCinoutData''',
        true,
      ) as List?;
  List<String>? checkinTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].shift_StartTime''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? checkOutTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].shft_EndTime''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ApiOnSitePOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    String? todayDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "employeeID": ${employeeID},
  "today_Date": "${todayDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiOnSite POST',
      apiUrl: '${baseUrl}/api/v1/StaffTimeAttendance/GetDayViewOfSTA',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic tADayView(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class ApiAllLeavePOSTCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    int? requesterID,
    int? monthNum,
    int? yearNum,
    String? startDate = '',
    String? endDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "month_Num": ${monthNum},
  "year_Num": ${yearNum},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "requester_ID": ${requesterID},
  "start_Date": "${startDate}",
  "end_Date": "${endDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiAllLeave POST',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/GetTimeOff_RequestByCompanyId',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? leaveAll(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class PaySlipCall {
  Future<ApiCallResponse> call({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyIDMain},
  "employee_ID": ${employeeIDMain}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PaySlip',
      apiUrl: '${baseUrl}/api/v1/SalaryDocument/GetPaidSalaryDocuments',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? periodEndDate(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].period_End_Date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class AddTimeOffRequestForEMPWholeDayCall {
  Future<ApiCallResponse> call({
    int? approverID,
    String? balance = '',
    String? endDate = '',
    String? message = '',
    bool? saveDraft,
    String? startDate = '',
    int? timeoffID,
    bool? wholeDay = true,
    String? workflowType = 'TimeOff',
    dynamic attachmentsJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "timeoff_ID": ${timeoffID},
  "wholeDay": ${wholeDay},
  "start_Date": "${startDate}",
  "end_Date": "${endDate}",
  "message": "${message}",
  "saveDraft": ${saveDraft},
  "requester_ID": ${employeeIDMain},
  "company_ID": ${companyIDMain},
  "balance": "${balance}",
  "approver_ID": ${approverID},
  "workflowType": "${workflowType}",
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddTimeOffRequestForEMPWholeDay',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/AddTimeOff_RequestForEmp',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class AddTimeOffRequestForEMPHalfDayCall {
  Future<ApiCallResponse> call({
    int? approverID,
    String? balance = '',
    String? endTime = '',
    String? message = '',
    String? requestedDate = '',
    bool? saveDraft,
    String? startTime = '',
    int? timeoffID,
    bool? wholeDay = true,
    String? workflowType = 'TimeOff',
    String? startDate = '',
    String? endDate = '',
    dynamic attachmentsJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "timeoff_ID": ${timeoffID},
  "wholeDay": ${wholeDay},
  "requested_Date": "${requestedDate}",
  "start_Time": "${startTime}",
  "end_Time": "${endTime}",
  "start_Date": "${startDate}",
  "end_Date": "${endDate}",
  "message": "${message}",
  "saveDraft": ${saveDraft},
  "requester_ID": ${employeeIDMain},
  "company_ID": ${companyIDMain},
  "balance": "${balance}",
  "approver_ID": ${approverID},
  "workflowType": "${workflowType}",
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddTimeOffRequestForEMPHalfDay',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/AddTimeOff_RequestForEmp',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class ApiTimeAttendanceDayViewPOSTCall {
  Future<ApiCallResponse> call({
    int? employeeID,
    String? todayDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "employee_ID": ${employeeID},
  "today_Date": "${todayDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiTimeAttendanceDayView POST',
      apiUrl: '${baseUrl}/api/v1/StaffTimeAttendance/GetEmployeeDataOfSTA',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic timeAttendanceView(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  List? timeAttendanceDayViewRegular(dynamic response) => getJsonField(
        response,
        r'''$.data.regCinoutData''',
        true,
      ) as List?;
  List? timeAttendanceDayViewIrregular(dynamic response) => getJsonField(
        response,
        r'''$.data.irrRegCinoutData''',
        true,
      ) as List?;
}

class AddClockInOutCall {
  Future<ApiCallResponse> call({
    bool? approve,
    String? clockInLattitude = '',
    String? clockInLocation = '',
    String? clockInTime = '',
    String? clockOutLattitude = '',
    String? clockOutLocation = '',
    String? clockOutLongitude = '',
    String? clockOutTime = '',
    int? companyID,
    int? employeeID,
    String? shftEndTime = '\"17:00\"',
    String? shiftStartTime = '\"08:00\"',
    int? timeID,
    String? timeType = '',
    int? userID,
    String? clockInLongitude = '',
    String? checkInImage = '',
    String? timeEntryDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "time_ID": ${timeID},
  "clock_In_Time": "${clockInTime}",
  "clock_Out_Time": "-",
  "clock_In_Location": "${clockInLocation}""",
  "clock_Out_Location": "-",
  "clock_In_Lattitude": "${clockInLattitude}",
  "clock_In_Longitude": "${clockInLongitude}",
  "clock_Out_Lattitude": "-",
  "clock_Out_Longitude": "-",
  "irregular_In_Time": "-",
  "irregular_Out_Time": "-",
  "irregular_In_Location": "-",
  "irregular_Out_Location": "-",
  "irregular_In_Lattitude": "-",
  "irregular_In_Longitude": "-",
  "irregular_Out_Lattitude": "-",
  "irregular_Out_Longitude": "-",
  "time_Type": "${timeType}",
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "approve": ${approve},
  "user_ID": ${userID},
  "shift_StartTime": "${shiftStartTime}",
  "shft_EndTime": "${shftEndTime}",
  "checkIn_Image": "${checkInImage}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddClockInOut',
      apiUrl: '${baseUrl}/api/v1/ClockInOut/AddClockInOut',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ApiCheckOutPOSTCall {
  Future<ApiCallResponse> call({
    bool? approve,
    int? clockID,
    String? clockInLattitude = '',
    String? clockInLocation = '',
    String? clockInLongitude = '',
    String? clockInTime = '',
    String? clockOutLattitude = '',
    String? clockOutLocation = '',
    String? clockOutLongitude = '',
    String? clockOutTime = '',
    int? companyID,
    int? employeeID,
    String? irregularInLattitude = '',
    String? irregularInLocation = '',
    String? irregularInLongitude = '',
    String? irregularInTime = '',
    String? irregularOutLattitude = '',
    String? irregularOutLocation = '',
    String? irregularOutLongitude = '',
    String? irregularOutTime = '',
    String? shftEndTime = '',
    String? shiftStartTime = '',
    int? timeID,
    String? timeType = '',
    int? userID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'apiCheckOut POST',
      apiUrl: '${baseUrl}/api/ClockInOut/UpdateClockInOut',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiLeaveRequestHalfDayPOSTCall {
  Future<ApiCallResponse> call({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'apiLeaveRequestHalfDay POST',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/AddTimeOff_RequestForEmp',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateStatusMyApprovalCall {
  Future<ApiCallResponse> call({
    String? requeststatus = '',
    String? status = '',
    int? wFID,
    String? reason = '',
    int? userID,
    int? approverOrder,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "reason": "${reason}",
  "wF_ID": ${wFID},
  "status": "${status}",
  "requeststatus": "${requeststatus}",
  "user_ID": ${userID},
  "approverOrder": ${approverOrder}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateStatusMyApproval',
      apiUrl: '${baseUrl}/api/v1/MyTasks/UpdateStatus',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class GetDayViewOfSTACall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    String? todayDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "today_Date": "${todayDate}",
  "employeeID": ${employeeID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetDayViewOfSTA',
      apiUrl: '${baseUrl}/api/v1/StaffTimeAttendance/GetDayViewOfSTA',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? irrRegCinoutData(dynamic response) => getJsonField(
        response,
        r'''$.data[:].irrRegCinoutData''',
        true,
      ) as List?;
  List? regCinoutData(dynamic response) => getJsonField(
        response,
        r'''$.data[:].regCinoutData''',
        true,
      ) as List?;
  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  int? timeID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].time_ID''',
      ));
  int? employeeID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].employee_ID''',
      ));
  String? startTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].start_Time''',
      ));
  String? endTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].end_Time''',
      ));
  String? employeeCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].employee_Code''',
      ));
  bool? approve(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].approve''',
      ));
  int? companyID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].company_ID''',
      ));
  List<int>? regCinoutDataUserID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].user_ID''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<int>? clockID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_ID''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? regclockInTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_In_Time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? regclockOutTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_Out_Time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clockInLocation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_In_Location''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clockOutLocation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_Out_Location''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clockInLattitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_In_Lattitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clockInLongitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_In_Longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clockOutLattitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_Out_Lattitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clockOutLongitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].clock_Out_Longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? checkInImage(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regCinoutData[:].checkIn_Image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otCinTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_In_Time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otCoutTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_Out_Time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otCinLocation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_In_Location''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otCinLattitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_In_Lattitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otCinLongitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_In_Longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otCheckInImage(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].checkIn_Image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otClockOutLocation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_Out_Location''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otClockOutLattitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_Out_Lattitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otClockOutLongitude(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_Out_Longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? oTClockID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].otCinoutData[:].clock_ID''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  bool? timeOffWholeDay(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].time_Off_Whole_Day''',
      ));
  List<String>? irregularClockInTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].irrRegCinoutData[:].clock_In_Time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? irregularClockOutTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].irrRegCinoutData[:].clock_Out_Time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? latestCheckIN(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].latest_Clock_In_Time''',
      ));
  String? lastestCheckOut(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].latest_Clock_Out_Time''',
      ));
}

class UpdateClockInOutCall {
  Future<ApiCallResponse> call({
    int? clockID,
    int? timeID,
    String? clockInTime = '',
    String? clockInLocation = '',
    String? clockInLattitude = '',
    String? clockInLongitude = '',
    String? clockOutTime = '',
    String? clockOutLocation = '',
    String? clockOutLattitude = '',
    String? clockOutLongitude = '',
    String? timeType = '',
    bool? approve,
    int? userID,
    String? shiftStartTime = '',
    String? shiftEndTime = '',
    String? checkOutImage = '',
    String? timeEntryDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "clock_ID": ${clockID},
  "time_ID": ${timeID},
  "clock_In_Time": "${clockInTime}",
  "clock_Out_Time": "${clockOutTime}",
  "clock_In_Location": "${clockInLocation}",
  "clock_Out_Location": "${clockOutLocation}",
  "clock_In_Lattitude": "${clockInLattitude}",
  "clock_In_Longitude": "${clockInLongitude}",
  "clock_Out_Lattitude": "${clockOutLattitude}",
  "clock_Out_Longitude": "${clockOutLongitude}",
  "time_Type": "${timeType}",
  "employee_ID": ${employeeIDMain},
  "company_ID": ${companyIDMain},
  "approve": ${approve},
  "irregular_In_Time": "-",
  "irregular_Out_Time": "-",
  "irregular_In_Location": "-",
  "irregular_Out_Location": "-",
  "irregular_In_Lattitude": "-",
  "irregular_In_Longitude": "-",
  "irregular_Out_Lattitude": "-",
  "irregular_Out_Longitude": "-",
  "user_ID": ${userID},
  "shift_StartTime": "${shiftStartTime}",
  "shft_EndTime": "${shiftEndTime}",
  "checkOut_Image": "${checkOutImage}",
  "timeEntry_Date": "${timeEntryDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateClockInOut',
      apiUrl: '${baseUrl}/api/v1/ClockInOut/UpdateClockInOut',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? data(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data''',
      ));
}

class GetTimeOffRequestByCompanyIdCall {
  Future<ApiCallResponse> call({
    int? monthNum,
    int? yearNum,
    int? requesterID,
    String? startDate = '',
    String? endDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "month_Num": ${monthNum},
  "year_Num": ${yearNum},
  "employee_ID": ${employeeIDMain},
  "company_ID": ${companyIDMain},
  "requester_ID": ${requesterID},
  "start_Date": "${startDate}",
  "end_Date": "${endDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetTimeOffRequestByCompanyId',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/GetTimeOff_RequestByCompanyId',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCustomerWebCall {
  Future<ApiCallResponse> call({
    int? timezoneOffset,
    int? companyID,
    int? employeeID,
    int? perpage,
    int? page,
    String? searchValue = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "employee_ID": ${employeeID},
  "timezoneOffset": ${timezoneOffset},
  "perpage": ${perpage},
  "page": ${page},
  "searchValue": "${searchValue}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetCustomerWeb',
      apiUrl: '${baseUrl}/api/v1/Announcement/GetCustomerWeb',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? announcementTitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].announcement_Title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? announcementImage(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].announcement_Image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? announcementDetail(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].announcement_Detail''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? announcementCreatedDate(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].createdAnnouncement_Date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? viewCount(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].viewCount''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? commentCount(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].countcomment''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  int? announcementID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].announcement_ID''',
      ));
  List? announcementList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetAnnouncementByIdCall {
  Future<ApiCallResponse> call({
    int? announcementID,
    int? timezoneOffset,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "announcement_ID": ${announcementID},
  "timezoneOffset": ${timezoneOffset}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetAnnouncementById',
      apiUrl: '${baseUrl}/api/v1/Announcement/GetAnnouncementbyID',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? announcementID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].announcement_ID''',
      ));
  String? announcementTitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].announcement_Title''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].image''',
      ));
  String? announcementCreatedDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].createdAnnouncement_Date''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].name''',
      ));
  String? announcementDetail(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].announcement_Detail''',
      ));
  String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].lastName''',
      ));
  String? announcementImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].announcement_Image''',
      ));
}

class GetPersonalInfoCall {
  Future<ApiCallResponse> call({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "employee_ID": ${employeeIDMain},
  "company_ID": ${companyIDMain}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetPersonalInfo',
      apiUrl: '${baseUrl}/api/v1/PersonalInfo/GetPersonalInfo',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  String? prefix(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].prefix''',
      ));
  String? mobile(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].mobile''',
      ));
  String? hiredDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].hiredDate''',
      ));
  String? departmentName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].departmentName''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].email''',
      ));
  String? nickname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].nickname''',
      ));
  int? apiStatus(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class UpdatePersonalInfoMobCall {
  Future<ApiCallResponse> call({
    String? image = '',
    String? mobile = '',
    String? email = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "employee_ID": ${employeeIDMain},
  "image": "${image}",
  "mobile": "${mobile}",
  "email": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdatePersonalInfoMob',
      apiUrl: '${baseUrl}/api/v1/PersonalInfo/UpdatePersonalInfoMob',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class GetTimeOffRequestByCompanyIdPaginationCall {
  Future<ApiCallResponse> call({
    int? monthNum,
    int? yearNum,
    int? employeeID,
    int? companyID,
    int? requesterID,
    int? leaveTypeID,
    String? status = '',
    int? perpage,
    int? page,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "month_Num": ${monthNum},
  "year_Num": ${yearNum},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "requester_ID": ${requesterID},
  "leaveType_ID": ${leaveTypeID},
  "status": "${status}",
  "perpage": ${perpage},
  "page": ${page}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetTimeOffRequestByCompanyIdPagination',
      apiUrl:
          '${baseUrl}/api/v1/TimeOff_Request/GetTimeOff_RequestByCompanyIdPagination',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? dataResult(dynamic response) => getJsonField(
        response,
        r'''$.data.result''',
        true,
      ) as List?;
  List? attachmentList(dynamic response) => getJsonField(
        response,
        r'''$.data.result[:].attachmentList''',
        true,
      ) as List?;
  List<String>? attachmentImgUrlList(dynamic response) => (getJsonField(
        response,
        r'''$.data.result[:].attachmentList[:].attachment''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ChangePasswordCall {
  Future<ApiCallResponse> call({
    String? oldPassword = '',
    String? newPassword = '',
    int? userID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "oldPassword": "${oldPassword}",
  "password": "${newPassword}",
  "user_ID": ${userID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ChangePassword',
      apiUrl: '${baseUrl}/api/v1/LoginInfo/ChangePassword',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class GetPersonalInfoForMobCall {
  Future<ApiCallResponse> call({
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "employee_ID": ${employeeIDMain}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetPersonalInfoForMob',
      apiUrl: '${baseUrl}/api/v1/PersonalInfo/GetPersonalInfoMob',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class StaffOTRequestCall {
  Future<ApiCallResponse> call({
    dynamic reqdataJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final reqdata = _serializeJson(reqdataJson);
    final ffApiRequestBody = '''
${reqdata}''';
    return ApiManager.instance.makeApiCall(
      callName: 'StaffOTRequest',
      apiUrl: '${baseUrl}/api/v1/OT_Request/StaffOT_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllLocationsByCompanyIDCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "companyID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllLocationsByCompanyID',
      apiUrl: '${baseUrl}/api/v1/WorkinLocation/GetAllLocationsByCompanyID',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? worklocationName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].workinLocationName''',
      ));
  dynamic coordinates(dynamic response) => getJsonField(
        response,
        r'''$.data[:].coordinates''',
      );
  dynamic radius(dynamic response) => getJsonField(
        response,
        r'''$.data[:].radius''',
      );
  bool? activeStaus(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].activeStatus''',
      ));
}

class GetDefaultSettingCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "companyID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefaultSetting',
      apiUrl:
          '${baseUrl}/api/v1/CheckIn_Out_MasterControlller/GetDefaultSetting',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? checkOutLocation(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.checkOutLocation''',
      ));
  int? checkInOffSite(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.checkInOffSite''',
      ));
  bool? isCheckInPicture(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.isCheckInPicture''',
      ));
  bool? isCheckOutPicture(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.isCheckOutPicture''',
      ));
  int? isRequireCheckIn(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.isRequireCheckIn''',
      ));
  int? isRequireCheckOut(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.isRequireCheckOut''',
      ));
  int? distanceCheckInLocation(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.distanceCheckInLocation''',
      ));
}

class AddClockInOutMobileCall {
  Future<ApiCallResponse> call({
    bool? approve = false,
    String? clockInLattitude = '',
    String? clockInLocation = '',
    String? clockInTime = '',
    String? clockOutLattitude = '',
    String? clockOutLocation = '',
    String? clockOutLongitude = '',
    String? clockOutTime = '',
    int? companyID,
    int? employeeID,
    String? shftEndTime = '',
    String? shiftStartTime = '',
    int? timeID,
    String? timeType = '',
    int? userID,
    String? clockInLongitude = '',
    String? checkInImage = '',
    String? clockInOutType = '',
    int? checkInStatus = 0,
    String? detail = '',
    String? offSiteLocation = '',
    String? timeEntryDate = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "time_ID": ${timeID},
  "clock_In_Time": "${escapeStringForJson(clockInTime)}",
  "clock_Out_Time": "-",
  "clock_In_Location": "${escapeStringForJson(clockInLocation)}",
  "clock_Out_Location": "-",
  "clock_In_Lattitude": "${escapeStringForJson(clockInLattitude)}",
  "clock_In_Longitude": "${escapeStringForJson(clockInLongitude)}",
  "clock_Out_Lattitude": "-",
  "clock_Out_Longitude": "-",
  "irregular_In_Time": "-",
  "irregular_Out_Time": "-",
  "irregular_In_Location": "-",
  "irregular_Out_Location": "-",
  "irregular_In_Lattitude": "-",
  "irregular_In_Longitude": "-",
  "irregular_Out_Lattitude": "-",
  "irregular_Out_Longitude": "-",
  "time_Type": "${escapeStringForJson(timeType)}",
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "approve": ${approve},
  "user_ID": ${userID},
  "shift_StartTime": "${escapeStringForJson(shiftStartTime)}",
  "shft_EndTime": "${escapeStringForJson(shftEndTime)}",
  "checkIn_Image": "${escapeStringForJson(checkInImage)}",
  "checkIn_Status": ${checkInStatus},
  "clock_In_Out_Type": "${escapeStringForJson(clockInOutType)}",
  "detail": "${escapeStringForJson(detail)}",
  "offSite_Location": "${escapeStringForJson(offSiteLocation)}",
  "timeEntry_Date": "${escapeStringForJson(timeEntryDate)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddClockInOutMobile',
      apiUrl: '${baseUrl}/api/v1/ClockInOut/AddClockInOut_Mobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTimeAttendanceListMobileCall {
  Future<ApiCallResponse> call({
    int? employeeID,
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetTimeAttendanceListMobile',
      apiUrl:
          '${baseUrl}/api/v1/StaffTimeAttendance/GetTimeAttendanceListMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? timeAttendanceList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class UpdateClockInOutMobileCall {
  Future<ApiCallResponse> call({
    int? timeID,
    int? clockID,
    String? clockInTime = '',
    String? clockOutTime = '',
    String? clockInLocation = '',
    String? clockOutLocation = '',
    String? clockInLattitude = '',
    String? clockInLongitude = '',
    String? clockOutLattitude = '',
    String? clockOutLongitude = '',
    String? irregularInTime = '',
    String? irregularOutTime = '',
    String? irregularInLocation = '',
    String? irregularOutLocation = '',
    String? irregularInLattitude = '',
    String? irregularInLongitude = '',
    String? irregularOutLattitude = '',
    String? irregularOutLongitude = '',
    bool? approve,
    String? timeType = '',
    int? employeeID,
    int? companyID,
    String? shiftStartTime = '',
    String? shftEndTime = '',
    int? userID,
    int? checkOutImage,
    String? detail = '',
    String? offSiteLocation = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "time_ID": ${timeID},
  "clock_ID": ${clockID},
  "clock_In_Time": "${escapeStringForJson(clockInTime)}",
  "clock_Out_Time": "${escapeStringForJson(clockOutTime)}",
  "clock_In_Location": "${escapeStringForJson(clockInLocation)}",
  "clock_Out_Location": "${escapeStringForJson(clockOutLocation)}",
  "clock_In_Lattitude": "${escapeStringForJson(clockInLattitude)}",
  "clock_In_Longitude": "${escapeStringForJson(clockInLongitude)}",
  "clock_Out_Lattitude": "${escapeStringForJson(clockOutLattitude)}",
  "clock_Out_Longitude": "${escapeStringForJson(clockOutLongitude)}",
  "irregular_In_Time": "${escapeStringForJson(irregularInTime)}",
  "irregular_Out_Time": "${escapeStringForJson(irregularOutTime)}",
  "irregular_In_Location": "${escapeStringForJson(irregularInLocation)}",
  "irregular_Out_Location": "${escapeStringForJson(irregularOutLocation)}",
  "irregular_In_Lattitude": "${escapeStringForJson(irregularInLattitude)}",
  "irregular_In_Longitude": "${escapeStringForJson(irregularInLongitude)}",
  "irregular_Out_Lattitude": "${escapeStringForJson(irregularOutLattitude)}",
  "irregular_Out_Longitude": "${escapeStringForJson(irregularOutLongitude)}",
  "approve": ${approve},
  "time_Type": "${escapeStringForJson(timeType)}",
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "shift_StartTime": "${escapeStringForJson(shiftStartTime)}",
  "shft_EndTime": "${escapeStringForJson(shftEndTime)}",
  "user_ID": ${userID},
  "checkOut_Image": "${checkOutImage}",
  "detail": "${escapeStringForJson(detail)}",
  "offSite_Location": "${escapeStringForJson(offSiteLocation)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateClockInOutMobile',
      apiUrl: '${baseUrl}/api/v1/ClockInOut/UpdateClockInOut_Mobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class GetPersonalInfoByCompanyIDCall {
  Future<ApiCallResponse> call({
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetPersonalInfoByCompanyID',
      apiUrl: '${baseUrl}/api/v1/PersonalInfo/GetPersonalInfoByCompanyID',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? fullName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].fullName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? employeeCode(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].employee_Code''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? email(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].email''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? mobile(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].mobile''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? positionName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].position_Name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? contactStaffList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetOTRequestByStatusMobileCall {
  Future<ApiCallResponse> call({
    String? monthNum = '',
    String? yearNum = '',
    int? status,
    int? employeeID,
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "month_Num": "${escapeStringForJson(monthNum)}",
  "year_Num": "${escapeStringForJson(yearNum)}",
  "status": ${status},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetOTRequestByStatusMobile',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetOT_RequestByStatusMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? oTPendingList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? otRequestDate(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].oT_Requested_Date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class OTCheckkOutMobileCall {
  Future<ApiCallResponse> call({
    int? clockID,
    String? clockOutTime = '',
    int? userID,
    dynamic attachmentsJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "clock_ID": ${clockID},
  "clock_Out_Time": "${escapeStringForJson(clockOutTime)}",
  "user_ID": ${userID},
  "attachments": 
    ${attachments}
  
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OTCheckkOutMobile',
      apiUrl: '${baseUrl}/api/v1/OT_Request/OTCheckkOutMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetOTDetailForCheckInOutMobileCall {
  Future<ApiCallResponse> call({
    int? oTRequestID,
    int? clockID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "oT_Request_ID": ${oTRequestID},
  "clock_ID": ${clockID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetOTDetailForCheckInOutMobile',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetOTDetailForCheckInOutMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? clockInTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.clock_In_Time''',
      ));
  String? clockOutTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.clock_Out_Time''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  List? attachment(dynamic response) => getJsonField(
        response,
        r'''$.data.attachments''',
        true,
      ) as List?;
  List<String>? attachmentList(dynamic response) => (getJsonField(
        response,
        r'''$.data.attachments[:].attachment_file''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCurrentOTMobileCall {
  Future<ApiCallResponse> call({
    int? timezoneOffset,
    int? employeeID,
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "timezoneOffset": ${timezoneOffset},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetCurrentOTMobile',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetCurrentOTMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic currentOTList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  String? checkinStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].checkInStatus''',
      ));
  int? otrequestID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].oT_Request_ID''',
      ));
  String? startDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].start_Date''',
      ));
  String? endDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].end_Date''',
      ));
  String? otStartTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_Start_Time''',
      ));
  String? otEndTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_End_Time''',
      ));
  String? oTHour(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_Hours''',
      ));
  String? otRequestDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_Requested_Date''',
      ));
  String? approvername(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].approvername''',
      ));
  String? note(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].purpose_OT''',
      ));
  String? clockInTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].clock_In_Time''',
      ));
  String? clockOutTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].clock_Out_Time''',
      ));
  int? clockID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].clock_ID''',
      ));
  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class GetOTRequestForspecificPaginationCall {
  Future<ApiCallResponse> call({
    int? monthNum,
    int? yearNum,
    int? employeeID,
    int? companyID,
    String? status = '',
    int? page,
    int? perpage,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "month_Num": ${monthNum},
  "year_Num": ${yearNum},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "status": "${escapeStringForJson(status)}",
  "page": ${page},
  "perpage": ${perpage}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetOTRequestForspecificPagination',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetOT_RequestForspecificPagination',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic pendingApproval(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class GetOTandTimeOffMobileCall {
  Future<ApiCallResponse> call({
    String? year = '',
    int? employeeID,
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "year": "${escapeStringForJson(year)}",
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetOTandTimeOffMobile',
      apiUrl: '${baseUrl}/api/v1/MyTasks/Get_OTandTimeOffMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateTimeOffRequestCall {
  Future<ApiCallResponse> call({
    int? timeOffRequestID,
    int? timeoffID,
    bool? wholeDay,
    String? startDate = '',
    String? endDate = '',
    String? oTRequestedDate = '',
    String? startTime = '',
    String? endTime = '',
    String? message = '',
    String? balance = '',
    bool? saveDraft,
    int? companyID,
    dynamic attachmentsJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson);
    final ffApiRequestBody = '''
{
  "time_off_RequestID": ${timeOffRequestID},
  "timeoff_ID": ${timeoffID},
  "wholeDay": ${wholeDay},
  "start_Date": "${escapeStringForJson(startDate)}",
  "end_Date": "${escapeStringForJson(endDate)}",
  "oT_Requested_Date": "${escapeStringForJson(oTRequestedDate)}",
  "start_Time": "${escapeStringForJson(startTime)}",
  "end_Time": "${escapeStringForJson(endTime)}",
  "message": "${escapeStringForJson(message)}",
  "balance": "${escapeStringForJson(balance)}",
  "saveDraft": ${saveDraft},
  "company_ID": ${companyID},
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateTimeOffRequest',
      apiUrl: '${baseUrl}​/api​/v1​/TimeOff_Request​/UpdateTimeOff_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ForgetPasswordCall {
  Future<ApiCallResponse> call({
    String? companyCode = '',
    int? companyId,
    int? userId,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "company_Code": "${escapeStringForJson(companyCode)}",
  "company_Id": ${companyId},
  "user_Id": ${userId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ForgetPassword',
      apiUrl: '${baseUrl}/api/v1/LoginInfo/ForgetPassword',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateOTRequestCall {
  Future<ApiCallResponse> call({
    bool? wholeDay,
    int? oTRequestID,
    String? startDate = '',
    String? endDate = '',
    String? oTStartTime = '',
    String? oTEndTime = '',
    String? oTHours = '',
    String? oTRequestedDate = '',
    String? purposeOT = '',
    bool? saveDraft,
    int? wFID,
    dynamic attachmentsJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "wholeDay": ${wholeDay},
  "oT_Request_ID": ${oTRequestID},
  "start_Date": "${escapeStringForJson(startDate)}",
  "end_Date": "${escapeStringForJson(endDate)}",
  "oT_Start_Time": "${escapeStringForJson(oTStartTime)}",
  "oT_End_Time": "${escapeStringForJson(oTEndTime)}",
  "oT_Hours": "${escapeStringForJson(oTHours)}",
  "oT_Requested_Date": "${escapeStringForJson(oTRequestedDate)}",
  "purpose_OT": "${escapeStringForJson(purposeOT)}",
  "saveDraft": ${saveDraft},
  "wF_ID": ${wFID},
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateOTRequest',
      apiUrl: '${baseUrl}/api/v1/OT_Request/UpdateOT_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OTRequestCall {
  Future<ApiCallResponse> call({
    String? requestedDate = '',
    bool? wholeDay,
    String? startDate = '',
    String? endDate = '',
    String? oTStartTime = '',
    String? oTEndTime = '',
    String? oTHours = '',
    String? purposeOT = '',
    bool? saveDraft,
    int? requesterID,
    int? approverID,
    int? approverID2,
    int? approverID3,
    int? approverID4,
    int? approverID5,
    int? companyID,
    dynamic attachmentsJson,
    String? oTType = '',
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "requestedDate": "${escapeStringForJson(requestedDate)}",
  "wholeDay": ${wholeDay},
  "start_Date": "${escapeStringForJson(startDate)}",
  "end_Date": "${escapeStringForJson(endDate)}",
  "oT_Start_Time": "${escapeStringForJson(oTStartTime)}",
  "oT_End_Time": "${escapeStringForJson(oTEndTime)}",
  "oT_Hours": "${escapeStringForJson(oTHours)}",
  "purpose_OT": "${escapeStringForJson(purposeOT)}",
  "saveDraft": ${saveDraft},
  "requester_ID": ${requesterID},
  "approver_ID": ${approverID},
  "approver_ID2": ${approverID2},
  "approver_ID3": ${approverID3},
  "approver_ID4": ${approverID4},
  "approver_ID5": ${approverID5},
  "company_ID": ${companyID},
  "oT_Type": "${escapeStringForJson(oTType)}",
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OTRequest',
      apiUrl: '${baseUrl}/api/v1/OT_Request/StaffOT_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateLeaveRequestCall {
  Future<ApiCallResponse> call({
    int? timeOffRequestID,
    int? timeoffID,
    bool? wholeDay,
    String? startDate = '',
    String? endDate = '',
    String? oTRequestedDate = '',
    String? startTime = '',
    String? endTime = '',
    String? message = '',
    String? balance = '',
    bool? saveDraft,
    int? companyID,
    dynamic attachmentsJson,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "time_off_RequestID": ${timeOffRequestID},
  "timeoff_ID": ${timeoffID},
  "wholeDay": ${wholeDay},
  "start_Date": "${escapeStringForJson(startDate)}",
  "end_Date": "${escapeStringForJson(endDate)}",
  "oT_Requested_Date": "${escapeStringForJson(oTRequestedDate)}",
  "start_Time": "${escapeStringForJson(startTime)}",
  "end_Time": "${escapeStringForJson(endTime)}",
  "message": "${escapeStringForJson(message)}",
  "balance": "${escapeStringForJson(balance)}",
  "saveDraft": ${saveDraft},
  "company_ID": ${companyID},
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateLeaveRequest',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/UpdateTimeOff_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteOTRequestsCall {
  Future<ApiCallResponse> call({
    int? oTRequestID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "oT_Request_ID": ${oTRequestID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteOTRequests',
      apiUrl: '${baseUrl}/api/v1/OT_Request/DeleteOT_Request',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteTimeOffCall {
  Future<ApiCallResponse> call({
    String? reason = '',
    int? timeOffRequestID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "reason": "${escapeStringForJson(reason)}",
  "time_off_RequestID": ${timeOffRequestID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteTimeOff',
      apiUrl: '${baseUrl}/api/v1/TimeOff_Request/DeleteTimeOff',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OTCheckInMobileCall {
  Future<ApiCallResponse> call({
    String? theDate = '',
    String? clockInTime = '',
    int? employeeID,
    int? companyID,
    int? userID,
    dynamic attachmentsJson,
    int? oTRequestID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final attachments = _serializeJson(attachmentsJson, true);
    final ffApiRequestBody = '''
{
  "the_Date": "${escapeStringForJson(theDate)}",
  "clock_In_Time": "${escapeStringForJson(clockInTime)}",
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "user_ID": ${userID},
  "oT_Request_ID": ${oTRequestID},
  "attachments": ${attachments}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OTCheckInMobile',
      apiUrl: '${baseUrl}/api/v1/OT_Request/OTCheckkInMobile',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? clockID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.clock_ID''',
      ));
}

class OvertimeListViewCall {
  Future<ApiCallResponse> call({
    int? timezoneOffset,
    int? employeeID,
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "timezoneOffset": ${timezoneOffset},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OvertimeListView',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetCurrentOTMobileList',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? oTRequestID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].oT_Request_ID''',
      ));
  String? oTStartTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_Start_Time''',
      ));
  String? oTEndTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_End_Time''',
      ));
  String? clockInTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].clock_In_Time''',
      ));
  String? clockOutTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].clock_Out_Time''',
      ));
  int? clockID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].clock_ID''',
      ));
  String? oTHours(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].oT_Hours''',
      ));
  List? currentListView(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetworkFlowOfOTRequestCall {
  Future<ApiCallResponse> call({
    int? employeeID,
    int? companyID,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "employee_ID": ${employeeID},
  "company_ID": ${companyID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetworkFlowOfOTRequest',
      apiUrl: '${baseUrl}/api/v1/OT_Request/GetworkFlowOfOTRequest',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? wFID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.wF_ID''',
      ));
  int? senderID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.requester_ID''',
      ));
}

class AddNotificationInfoMobCall {
  Future<ApiCallResponse> call({
    int? wFID,
    int? senderID,
    int? recipientID,
    bool? seen,
    String? description = '',
    bool? delicated,
    int? companyIDMain,
    int? employeeIDMain,
    String? todayDateMain = '',
    String? token = '',
  }) async {
    final baseUrl = MainGroup.getBaseUrl(
      companyIDMain: companyIDMain,
      employeeIDMain: employeeIDMain,
      todayDateMain: todayDateMain,
      token: token,
    );

    final ffApiRequestBody = '''
{
  "wF_ID": ${wFID},
  "senderID": ${senderID},
  "recipientID": ${recipientID},
  "seen": ${seen},
  "description": "${escapeStringForJson(description)}",
  "delicated": ${delicated}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddNotificationInfoMob',
      apiUrl: '${baseUrl}/api/v1/NotificationInfo/AddNotificationInfoMob',
      callType: ApiCallType.POST,
      headers: {
        'authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End main Group Code

class GetAllLeaveCall {
  static Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
    int? requesterID,
    int? monthNum,
    int? yearNum,
    String? startDate = '',
    String? endDate = '',
  }) async {
    final ffApiRequestBody = '''
{
  "month_Num": ${monthNum},
  "year_Num": ${yearNum},
  "employee_ID": ${employeeID},
  "company_ID": ${companyID},
  "requester_ID": ${requesterID},
  "start_Date": "${startDate}",
  "end_Date": "${endDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllLeave',
      apiUrl:
          'https://optimisticwebapis.azurewebsites.net/api/TimeOff_Request/GetTimeOff_RequestByCompanyId',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? getLeave(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetApprovalCall {
  static Future<ApiCallResponse> call({
    int? companyID,
    int? employeeID,
  }) async {
    final ffApiRequestBody = '''
{
  "company_ID": ${companyID},
  "employee_ID": ${employeeID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetApproval',
      apiUrl:
          'https://optimisticwebapis.azurewebsites.net/api/MyTasks/Get_OTandTimeOff',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? getApprovalList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ApiGoogleMapsLoactionGETCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'apiGoogleMapsLoaction GET',
      apiUrl:
          'https://jarviz-api.azurewebsites.net/api/v4/Address/GetAddress?originvalue=13.7205312159185,100.489133410156',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? googleMapsLocation(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  static String? googleMapsAddress(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].formatted_address''',
      ));
}

class GetCheckInImageURLCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? file,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCheckInImageURL',
      apiUrl:
          'https://task-cite-nuttakrit-api.azurewebsites.net/Api/Authentication/UploadImage',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'image': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic imgURL(dynamic response) => getJsonField(
        response,
        r'''$.image''',
      );
  static int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class ApiGetAddressCall {
  static Future<ApiCallResponse> call({
    String? originalValue = '',
    String? userId = '',
    String? companyId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'apiGetAddress',
      apiUrl:
          'https://jarviz-api.azurewebsites.net/api/v6/Address/GetAddress?originvalue=${originalValue}&userID=${userId}&companyID=${companyId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? location(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].formatted_address''',
      ));
  static int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class PersonalInfoGetPersonalInfoByCompanyIDCall {
  static Future<ApiCallResponse> call({
    int? companyID,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'PersonalInfoGetPersonalInfoByCompanyID',
      apiUrl:
          'https://optimisticwebapis-dotnet8-eaapgpcndtaeeud4.southeastasia-01.azurewebsites.net/api/v1/PersonalInfo/GetPersonalInfoByCompanyID',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserbyCompanyIdCall {
  static Future<ApiCallResponse> call({
    int? companyId,
  }) async {
    final ffApiRequestBody = '''
{
  "companyId": ${companyId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getUserbyCompanyId',
      apiUrl:
          'https://optimisticwebapis-dotnet8-eaapgpcndtaeeud4.southeastasia-01.azurewebsites.net/api/v1/UserInfo/GetUserbyCompanyId',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? userID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].userId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? userName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].userName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCompanyCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCompany',
      apiUrl:
          'https://optimisticwebapis-dotnet8-eaapgpcndtaeeud4.southeastasia-01.azurewebsites.net/api/v1/Company/GetCompany',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ForgotPasswordCall {
  static Future<ApiCallResponse> call({
    String? companyCode = '',
    int? companyId,
    int? userId,
  }) async {
    final ffApiRequestBody = '''
{
  "company_Code": "${escapeStringForJson(companyCode)}",
  "company_Id": ${companyId},
  "user_Id": ${userId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ForgotPassword',
      apiUrl:
          'https://optimisticwebapis-dotnet8-eaapgpcndtaeeud4.southeastasia-01.azurewebsites.net/api/v1/LoginInfo/ForgetPassword',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
