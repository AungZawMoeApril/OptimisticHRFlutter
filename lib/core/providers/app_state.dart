import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String? _token;
  String? _companyId;
  String? _employeeId;
  
  String? get token => _token;
  String? get companyId => _companyId;
  String? get employeeId => _employeeId;
  
  void updateToken(String? token) {
    _token = token;
    notifyListeners();
  }
  
  void updateCompanyId(String? id) {
    _companyId = id;
    notifyListeners();
  }
  
  void updateEmployeeId(String? id) {
    _employeeId = id;
    notifyListeners();
  }
}