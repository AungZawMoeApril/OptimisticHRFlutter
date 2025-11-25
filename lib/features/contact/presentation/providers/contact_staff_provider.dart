import 'package:flutter/material.dart';
import '../../domain/entities/contact_staff.dart';
import '../../domain/usecases/get_contact_staff.dart';
import '../../domain/usecases/search_contact_staff.dart';

class ContactStaffProvider extends ChangeNotifier {
  final GetContactStaff getContactStaffUseCase;
  final SearchContactStaff searchContactStaffUseCase;

  ContactStaffProvider({
    required this.getContactStaffUseCase,
    required this.searchContactStaffUseCase,
  });

  List<ContactStaff> _contacts = [];
  List<ContactStaff> get contacts => _contacts;
  
  List<ContactStaff> _filteredContacts = [];
  List<ContactStaff> get filteredStaff => _filteredContacts.isEmpty ? _contacts : _filteredContacts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Future<void> loadContacts(String companyId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _contacts = await getContactStaffUseCase(companyId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchContacts(String query) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _contacts = await searchContactStaffUseCase(query);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Convenience methods for alternative naming
  Future<void> loadContactStaffList() => loadContacts('');
  
  void searchStaff(String query) {
    if (query.isEmpty) {
      _filteredContacts = [];
    } else {
      _filteredContacts = _contacts.where((staff) {
        final searchLower = query.toLowerCase();
        return staff.name.toLowerCase().contains(searchLower) ||
               staff.position.toLowerCase().contains(searchLower) ||
               staff.department.toLowerCase().contains(searchLower);
      }).toList();
    }
    notifyListeners();
  }
}