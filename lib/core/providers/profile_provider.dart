import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../data/models/profile.dart';
import '../data/repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repository;
  
  ProfileProvider([ProfileRepository? repository])
      : _repository = repository ?? GetIt.instance<ProfileRepository>();

  Profile? _profile;
  Profile? get profile => _profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadProfile() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _repository.getProfile();
    } catch (e) {
      _error = 'Error loading profile: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProfile(Profile profile) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.saveProfile(profile);
      _profile = profile;
    } catch (e) {
      _error = 'Error saving profile: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? position,
    String? department,
    String? email,
    String? phone,
    String? imageUrl,
  }) async {
    if (_profile == null) return;

    final updatedProfile = _profile!.copyWith(
      firstName: firstName,
      lastName: lastName,
      position: position,
      department: department,
      email: email,
      phone: phone,
      imageUrl: imageUrl,
    );

    await saveProfile(updatedProfile);
  }

  Future<void> clearProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.clearProfile();
      _profile = null;
    } catch (e) {
      _error = 'Error clearing profile: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}