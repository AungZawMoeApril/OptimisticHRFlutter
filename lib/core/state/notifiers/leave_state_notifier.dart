import 'base_state_notifier.dart';
import '../../storage/storage_manager.dart' as storage_manager;

class LeaveStateNotifier extends BaseStateNotifier {
  List<Map<String, dynamic>> _leaveRequests = [];
  double _remainingAnnualLeave = 0;
  double _remainingSickLeave = 0;
  Map<String, double> _otherLeaveBalances = {};

  LeaveStateNotifier() : super(storage_manager.StorageManager.leaveBox);

  List<Map<String, dynamic>> get leaveRequests => List.unmodifiable(_leaveRequests);
  double get remainingAnnualLeave => _remainingAnnualLeave;
  double get remainingSickLeave => _remainingSickLeave;
  Map<String, double> get otherLeaveBalances => Map.unmodifiable(_otherLeaveBalances);

  @override
  Future<void> loadState() async {
    final requests = await getValue<List>('leave_requests') ?? [];
    _leaveRequests = requests.cast<Map<String, dynamic>>();

    _remainingAnnualLeave = (await getValue('leave_annual_balance')) ?? 0.0;
    _remainingSickLeave = (await getValue('leave_sick_balance')) ?? 0.0;
    
    final balances = await getValue<Map>('leave_other_balances') ?? {};
    _otherLeaveBalances = balances.cast<String, double>();
  }

  @override
  Future<void> saveState() async {
    await setValue('leave_requests', _leaveRequests);
    await setValue('leave_annual_balance', _remainingAnnualLeave);
    await setValue('leave_sick_balance', _remainingSickLeave);
    await setValue('leave_other_balances', _otherLeaveBalances);
  }

  Future<void> addLeaveRequest(Map<String, dynamic> request) async {
    _leaveRequests = [..._leaveRequests, request];
    await saveState();
    notifyListeners();
  }

  Future<void> updateLeaveRequest(String requestId, Map<String, dynamic> updatedRequest) async {
    final index = _leaveRequests.indexWhere((req) => req['id'] == requestId);
    if (index != -1) {
      _leaveRequests[index] = updatedRequest;
      await saveState();
      notifyListeners();
    }
  }

  Future<void> updateLeaveBalances({
    double? annualLeave,
    double? sickLeave,
    Map<String, double>? otherBalances,
  }) async {
    bool changed = false;

    if (annualLeave != null && annualLeave != _remainingAnnualLeave) {
      _remainingAnnualLeave = annualLeave;
      changed = true;
    }

    if (sickLeave != null && sickLeave != _remainingSickLeave) {
      _remainingSickLeave = sickLeave;
      changed = true;
    }

    if (otherBalances != null) {
      _otherLeaveBalances = Map<String, double>.from(otherBalances);
      changed = true;
    }

    if (changed) {
      await saveState();
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _leaveRequests = [];
    _remainingAnnualLeave = 0;
    _remainingSickLeave = 0;
    _otherLeaveBalances = {};
    await saveState();
    await super.clear();
  }
}