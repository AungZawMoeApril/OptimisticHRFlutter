import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';

import '../../base_local_data_source.dart';
import '../../../storage/boxes.dart';
import '../../../storage/storage_service.dart';

/// Local data source for profile related data
class ProfileLocalDataSource extends BaseLocalDataSource {
  ProfileLocalDataSource() : super(GetIt.instance<IStorageService>(), Boxes.profile);

  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _positionKey = 'position';
  static const String _departmentKey = 'department';
  static const String _emailKey = 'email';
  static const String _phoneKey = 'phone';
  static const String _imageKey = 'image';

  @useResult
  Future<String?> getFirstName() => getCachedItem<String>(_firstNameKey);
  Future<void> cacheFirstName(String value) => cacheItem(_firstNameKey, value);

  @useResult
  Future<String?> getLastName() => getCachedItem<String>(_lastNameKey);
  Future<void> cacheLastName(String value) => cacheItem(_lastNameKey, value);

  @useResult
  Future<String?> getPosition() => getCachedItem<String>(_positionKey);
  Future<void> cachePosition(String value) => cacheItem(_positionKey, value);

  @useResult
  Future<String?> getDepartment() => getCachedItem<String>(_departmentKey);
  Future<void> cacheDepartment(String value) => cacheItem(_departmentKey, value);

  @useResult
  Future<String?> getEmail() => getCachedItem<String>(_emailKey);
  Future<void> cacheEmail(String value) => cacheItem(_emailKey, value);

  @useResult
  Future<String?> getPhone() => getCachedItem<String>(_phoneKey);
  Future<void> cachePhone(String value) => cacheItem(_phoneKey, value);

  @useResult
  Future<String?> getProfileImage() => getCachedItem<String>(_imageKey);
  Future<void> cacheProfileImage(String value) => cacheItem(_imageKey, value);

  // Clear all profile data
  Future<void> clearProfile() => clearAll();
}