import 'package:meta/meta.dart';
import '../sources/local/profile_local_data_source.dart';
import '../models/profile.dart';

/// Repository for managing user profile data
class ProfileRepository {
  final ProfileLocalDataSource _localDataSource;

  ProfileRepository(this._localDataSource);

  @useResult
  Future<Profile?> getProfile() async {
    try {
      final firstName = await _localDataSource.getFirstName();
      final lastName = await _localDataSource.getLastName();
      final position = await _localDataSource.getPosition();
      final department = await _localDataSource.getDepartment();
      final email = await _localDataSource.getEmail();
      final phone = await _localDataSource.getPhone();
      final image = await _localDataSource.getProfileImage();

      if (firstName == null) return null;

      return Profile(
        firstName: firstName,
        lastName: lastName ?? '',
        position: position ?? '',
        department: department ?? '',
        email: email ?? '',
        phone: phone ?? '',
        imageUrl: image,
      );
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  Future<void> saveProfile(Profile profile) async {
    try {
      await Future.wait([
        _localDataSource.cacheFirstName(profile.firstName),
        _localDataSource.cacheLastName(profile.lastName),
        _localDataSource.cachePosition(profile.position),
        _localDataSource.cacheDepartment(profile.department),
        _localDataSource.cacheEmail(profile.email),
        _localDataSource.cachePhone(profile.phone),
        if (profile.imageUrl != null)
          _localDataSource.cacheProfileImage(profile.imageUrl!),
      ]);
    } catch (e) {
      print('Error saving profile: $e');
    }
  }

  Future<void> clearProfile() => _localDataSource.clearProfile();
}