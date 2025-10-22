import 'base_state_notifier.dart';

import '../../storage/storage_manager.dart' show StorageManager;

class ProfileStateNotifier extends BaseStateNotifier {
  String? _firstName;
  String? _lastName;
  String? _positionName;
  String? _departmentName;
  String? _profileImage;
  String? _email;
  String? _phoneNumber;

  ProfileStateNotifier() : super(StorageManager.profileBox);

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get positionName => _positionName;
  String? get departmentName => _departmentName;
  String? get profileImage => _profileImage;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;

  String get fullName => '${_firstName ?? ''} ${_lastName ?? ''}'.trim();

  @override
  Future<void> loadState() async {
    _firstName = await getValue<String>('profile_first_name');
    _lastName = await getValue<String>('profile_last_name');
    _positionName = await getValue<String>('profile_position');
    _departmentName = await getValue<String>('profile_department');
    _profileImage = await getValue<String>('profile_image');
    _email = await getValue<String>('profile_email');
    _phoneNumber = await getValue<String>('profile_phone');
  }

  @override
  Future<void> saveState() async {
    await setValue<String>('profile_first_name', _firstName);
    await setValue<String>('profile_last_name', _lastName);
    await setValue<String>('profile_position', _positionName);
    await setValue<String>('profile_department', _departmentName);
    await setValue<String>('profile_image', _profileImage);
    await setValue<String>('profile_email', _email);
    await setValue<String>('profile_phone', _phoneNumber);
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? positionName,
    String? departmentName,
    String? profileImage,
    String? email,
    String? phoneNumber,
  }) async {
    bool changed = false;

    if (firstName != null && firstName != _firstName) {
      _firstName = firstName;
      changed = true;
    }
    if (lastName != null && lastName != _lastName) {
      _lastName = lastName;
      changed = true;
    }
    if (positionName != null && positionName != _positionName) {
      _positionName = positionName;
      changed = true;
    }
    if (departmentName != null && departmentName != _departmentName) {
      _departmentName = departmentName;
      changed = true;
    }
    if (profileImage != null && profileImage != _profileImage) {
      _profileImage = profileImage;
      changed = true;
    }
    if (email != null && email != _email) {
      _email = email;
      changed = true;
    }
    if (phoneNumber != null && phoneNumber != _phoneNumber) {
      _phoneNumber = phoneNumber;
      changed = true;
    }

    if (changed) {
      await saveState();
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _firstName = null;
    _lastName = null;
    _positionName = null;
    _departmentName = null;
    _profileImage = null;
    _email = null;
    _phoneNumber = null;
    await saveState();
    await super.clear();
  }
}