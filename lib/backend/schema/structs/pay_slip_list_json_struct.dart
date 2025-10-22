// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class PaySlipListJsonStruct extends BaseStruct {
  PaySlipListJsonStruct({
    int? employeeID,
    int? companyID,
    int? payDueID,
    String? periodStartDate,
    String? periodEndDate,
  })  : _employeeID = employeeID,
        _companyID = companyID,
        _payDueID = payDueID,
        _periodStartDate = periodStartDate,
        _periodEndDate = periodEndDate;

  // "employee_ID" field.
  int? _employeeID;
  int get employeeID => _employeeID ?? 0;
  set employeeID(int? val) => _employeeID = val;

  void incrementEmployeeID(int amount) => employeeID = employeeID + amount;

  bool hasEmployeeID() => _employeeID != null;

  // "company_ID" field.
  int? _companyID;
  int get companyID => _companyID ?? 0;
  set companyID(int? val) => _companyID = val;

  void incrementCompanyID(int amount) => companyID = companyID + amount;

  bool hasCompanyID() => _companyID != null;

  // "payDue_ID" field.
  int? _payDueID;
  int get payDueID => _payDueID ?? 0;
  set payDueID(int? val) => _payDueID = val;

  void incrementPayDueID(int amount) => payDueID = payDueID + amount;

  bool hasPayDueID() => _payDueID != null;

  // "period_Start_Date" field.
  String? _periodStartDate;
  String get periodStartDate => _periodStartDate ?? '';
  set periodStartDate(String? val) => _periodStartDate = val;

  bool hasPeriodStartDate() => _periodStartDate != null;

  // "period_End_Date" field.
  String? _periodEndDate;
  String get periodEndDate => _periodEndDate ?? '';
  set periodEndDate(String? val) => _periodEndDate = val;

  bool hasPeriodEndDate() => _periodEndDate != null;

  static PaySlipListJsonStruct fromMap(Map<String, dynamic> data) =>
      PaySlipListJsonStruct(
        employeeID: castToType<int>(data['employee_ID']),
        companyID: castToType<int>(data['company_ID']),
        payDueID: castToType<int>(data['payDue_ID']),
        periodStartDate: data['period_Start_Date'] as String?,
        periodEndDate: data['period_End_Date'] as String?,
      );

  static PaySlipListJsonStruct? maybeFromMap(dynamic data) => data is Map
      ? PaySlipListJsonStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'employee_ID': _employeeID,
        'company_ID': _companyID,
        'payDue_ID': _payDueID,
        'period_Start_Date': _periodStartDate,
        'period_End_Date': _periodEndDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'employee_ID': serializeParam(
          _employeeID,
          ParamType.int,
        ),
        'company_ID': serializeParam(
          _companyID,
          ParamType.int,
        ),
        'payDue_ID': serializeParam(
          _payDueID,
          ParamType.int,
        ),
        'period_Start_Date': serializeParam(
          _periodStartDate,
          ParamType.String,
        ),
        'period_End_Date': serializeParam(
          _periodEndDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static PaySlipListJsonStruct fromSerializableMap(Map<String, dynamic> data) =>
      PaySlipListJsonStruct(
        employeeID: deserializeParam(
          data['employee_ID'],
          ParamType.int,
          false,
        ),
        companyID: deserializeParam(
          data['company_ID'],
          ParamType.int,
          false,
        ),
        payDueID: deserializeParam(
          data['payDue_ID'],
          ParamType.int,
          false,
        ),
        periodStartDate: deserializeParam(
          data['period_Start_Date'],
          ParamType.String,
          false,
        ),
        periodEndDate: deserializeParam(
          data['period_End_Date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PaySlipListJsonStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PaySlipListJsonStruct &&
        employeeID == other.employeeID &&
        companyID == other.companyID &&
        payDueID == other.payDueID &&
        periodStartDate == other.periodStartDate &&
        periodEndDate == other.periodEndDate;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([employeeID, companyID, payDueID, periodStartDate, periodEndDate]);
}

PaySlipListJsonStruct createPaySlipListJsonStruct({
  int? employeeID,
  int? companyID,
  int? payDueID,
  String? periodStartDate,
  String? periodEndDate,
}) =>
    PaySlipListJsonStruct(
      employeeID: employeeID,
      companyID: companyID,
      payDueID: payDueID,
      periodStartDate: periodStartDate,
      periodEndDate: periodEndDate,
    );
