import 'base_state_notifier.dart';
import '../../storage/storage_manager.dart' as storage_manager;

class OvertimeStateNotifier extends BaseStateNotifier {
  List<Map<String, dynamic>> _overtimeRequests = [];
  Map<String, dynamic>? _currentOvertime;
  double _totalOvertimeHours = 0;
  bool _isInOvertime = false;

  OvertimeStateNotifier() : super(storage_manager.StorageManager.overtimeBox);

  List<Map<String, dynamic>> get overtimeRequests => List.unmodifiable(_overtimeRequests);
  Map<String, dynamic>? get currentOvertime => _currentOvertime;
  double get totalOvertimeHours => _totalOvertimeHours;
  bool get isInOvertime => _isInOvertime;

  @override
  Future<void> loadState() async {
    final requests = await getValue<List>('overtime_requests') ?? [];
    _overtimeRequests = requests.cast<Map<String, dynamic>>();

    _currentOvertime = await getValue('overtime_current');
    _totalOvertimeHours = (await getValue('overtime_total_hours')) ?? 0.0;
    _isInOvertime = (await getValue('overtime_is_active')) ?? false;
  }

  @override
  Future<void> saveState() async {
    await setValue('overtime_requests', _overtimeRequests);
    await setValue('overtime_current', _currentOvertime);
    await setValue('overtime_total_hours', _totalOvertimeHours);
    await setValue('overtime_is_active', _isInOvertime);
  }

  Future<void> startOvertime(Map<String, dynamic> overtimeData) async {
    _currentOvertime = overtimeData;
    _isInOvertime = true;
    await saveState();
    notifyListeners();
  }

  Future<void> endOvertime({
    required double hours,
    required Map<String, dynamic> overtimeRecord,
  }) async {
    _currentOvertime = null;
    _isInOvertime = false;
    _totalOvertimeHours += hours;
    _overtimeRequests = [..._overtimeRequests, overtimeRecord];
    await saveState();
    notifyListeners();
  }

  Future<void> addOvertimeRequest(Map<String, dynamic> request) async {
    _overtimeRequests = [..._overtimeRequests, request];
    await saveState();
    notifyListeners();
  }

  Future<void> updateOvertimeRequest(String requestId, Map<String, dynamic> updatedRequest) async {
    final index = _overtimeRequests.indexWhere((req) => req['id'] == requestId);
    if (index != -1) {
      _overtimeRequests[index] = updatedRequest;
      await saveState();
      notifyListeners();
    }
  }

  Future<void> updateTotalHours(double hours) async {
    if (hours != _totalOvertimeHours) {
      _totalOvertimeHours = hours;
      await saveState();
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _overtimeRequests = [];
    _currentOvertime = null;
    _totalOvertimeHours = 0;
    _isInOvertime = false;
    await saveState();
    await super.clear();
  }
}