class LeaveBalanceResponse {
  final List<LeaveType> leaveTypes;
  final String status;
  final String message;

  LeaveBalanceResponse({
    required this.leaveTypes,
    required this.status,
    required this.message,
  });

  factory LeaveBalanceResponse.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceResponse(
      leaveTypes: (json['data'] as List).map((e) => LeaveType.fromJson(e)).toList(),
      status: json['status'],
      message: json['message'],
    );
  }
}

class LeaveType {
  final int timeOffId;
  final String timeOffName;
  final String timeOffTypeEN;
  final double leaveDaysLeft;

  LeaveType({
    required this.timeOffId,
    required this.timeOffName,
    required this.timeOffTypeEN,
    required this.leaveDaysLeft,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      timeOffId: json['timeoff_ID'],
      timeOffName: json['timeoff_Name'],
      timeOffTypeEN: json['timeoff_TypeEN'],
      leaveDaysLeft: double.parse(json['leaveDaysLeft'].toString()),
    );
  }
}

class LeaveRequest {
  final String timeOffRequestId;
  final int timeOffId;
  final String timeOffName;
  final String startDate;
  final String endDate;
  final String? startTime;
  final String? endTime;
  final String message;
  final List<String> attachments;
  final bool wholeDay;
  final String balance;

  LeaveRequest({
    required this.timeOffRequestId,
    required this.timeOffId,
    required this.timeOffName,
    required this.startDate,
    required this.endDate,
    this.startTime,
    this.endTime,
    required this.message,
    required this.attachments,
    required this.wholeDay,
    required this.balance,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      timeOffRequestId: json['time_off_RequestID'],
      timeOffId: json['timeoff_ID'],
      timeOffName: json['timeoff_Name'],
      startDate: json['start_Date'],
      endDate: json['end_Date'],
      startTime: json['start_Time'],
      endTime: json['end_Time'],
      message: json['message'],
      attachments: List<String>.from(json['attachmentList']?.map((x) => x['attachment']) ?? []),
      wholeDay: json['whole_Day'] ?? true,
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_off_RequestID': timeOffRequestId,
      'timeoff_ID': timeOffId,
      'timeoff_Name': timeOffName,
      'start_Date': startDate,
      'end_Date': endDate,
      'start_Time': startTime,
      'end_Time': endTime,
      'message': message,
      'attachmentList': attachments.map((x) => {'attachment': x}).toList(),
      'whole_Day': wholeDay,
      'balance': balance,
    };
  }
}