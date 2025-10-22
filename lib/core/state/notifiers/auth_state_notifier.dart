import 'base_state_notifier.dart';
import '../../storage/storage_manager.dart' as storage_manager;

class AuthStateNotifier extends BaseStateNotifier {
  String? _token;
  String? _companyId;
  String? _employeeId;
  String? _userId;
  bool _canApprove = false;

  AuthStateNotifier() : super('auth_box');

  String? get token => _token;
  String? get companyId => _companyId;
  String? get employeeId => _employeeId;
  String? get userId => _userId;
  bool get canApprove => _canApprove;

  @override
  Future<void> loadState() async {
    _token = await getValue('token');
    _companyId = await getValue('company_id');
    _employeeId = await getValue('employee_id');
    _userId = await getValue('user_id');
    _canApprove = await getValue('can_approve', false) ?? false;
  }

  @override
  Future<void> saveState() async {
    await setValue('token', _token);
    await setValue('company_id', _companyId);
    await setValue('employee_id', _employeeId);
    await setValue('user_id', _userId);
    await setValue('can_approve', _canApprove);
  }

  Future<void> setAuthData({
    String? token,
    String? companyId,
    String? employeeId,
    String? userId,
    bool? canApprove,
  }) async {
    bool changed = false;

    if (token != null && token != _token) {
      _token = token;
      changed = true;
    }
    if (companyId != null && companyId != _companyId) {
      _companyId = companyId;
      changed = true;
    }
    if (employeeId != null && employeeId != _employeeId) {
      _employeeId = employeeId;
      changed = true;
    }
    if (userId != null && userId != _userId) {
      _userId = userId;
      changed = true;
    }
    if (canApprove != null && canApprove != _canApprove) {
      _canApprove = canApprove;
      changed = true;
    }

    if (changed) {
      await saveState();
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _token = null;
    _companyId = null;
    _employeeId = null;
    _userId = null;
    _canApprove = false;
    await saveState();
    await super.clear();
  }
}