import 'package:flutter/material.dart';

import 'base_state.dart';
import '../storage/secure_storage.dart';

/// Authentication state model
class AuthState extends BaseState {
  final SecureStorageProvider _storage;
  
  String _token = '';
  int _companyID = 0;
  int _employeeID = 0;
  int _userID = 0;
  bool _approve = false;

  AuthState(this._storage);

  String get token => _token;
  int get companyID => _companyID;
  int get employeeID => _employeeID;
  int get userID => _userID;
  bool get approve => _approve;

  @override
  Future<void> initialize() async {
    _token = await _storage.getValue('auth_token', '') ?? '';
    _companyID = await _storage.getValue('auth_company_id', 0) ?? 0;
    _employeeID = await _storage.getValue('auth_employee_id', 0) ?? 0;
    _userID = await _storage.getValue('auth_user_id', 0) ?? 0;
    _approve = await _storage.getValue('auth_approve', false) ?? false;
    markInitialized();
  }

  Future<void> updateAuth({
    String? token,
    int? companyID,
    int? employeeID,
    int? userID,
    bool? approve,
  }) async {
    if (token != null && token != _token) {
      _token = token;
      await _storage.setValue('auth_token', token);
    }
    if (companyID != null && companyID != _companyID) {
      _companyID = companyID;
      await _storage.setValue('auth_company_id', companyID);
    }
    if (employeeID != null && employeeID != _employeeID) {
      _employeeID = employeeID;
      await _storage.setValue('auth_employee_id', employeeID);
    }
    if (userID != null && userID != _userID) {
      _userID = userID;
      await _storage.setValue('auth_user_id', userID);
    }
    if (approve != null && approve != _approve) {
      _approve = approve;
      await _storage.setValue('auth_approve', approve);
    }
    notifyListeners();
  }

  @override
  Future<void> clear() async {
    _token = '';
    _companyID = 0;
    _employeeID = 0;
    _userID = 0;
    _approve = false;
    
    notifyListeners();
  }
}