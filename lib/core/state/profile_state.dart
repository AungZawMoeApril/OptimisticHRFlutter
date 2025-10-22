import 'base_state.dart';
import '../storage/secure_storage.dart';

/// Profile state model
class ProfileState extends BaseState {
  final SecureStorageProvider _storage;
  
  String _firstName = '';
  String _lastName = '';
  String _positionName = '';
  String _imagesFile = '';
  String _logoImage = '';
  String _colorCode = '';

  ProfileState(this._storage);

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get positionName => _positionName;
  String get imagesFile => _imagesFile;
  String get logoImage => _logoImage;
  String get colorCode => _colorCode;

  @override
  Future<void> initialize() async {
    _firstName = await _storage.getValue('profile_first_name', '') ?? '';
    _lastName = await _storage.getValue('profile_last_name', '') ?? '';
    _positionName = await _storage.getValue('profile_position_name', '') ?? '';
    _imagesFile = await _storage.getValue('profile_images_file', '') ?? '';
    _logoImage = await _storage.getValue('profile_logo_image', '') ?? '';
    _colorCode = await _storage.getValue('profile_color_code', '') ?? '';
    markInitialized();
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? positionName,
    String? imagesFile,
    String? logoImage,
    String? colorCode,
  }) async {
    if (firstName != null && firstName != _firstName) {
      _firstName = firstName;
      await _storage.setValue('profile_first_name', firstName);
    }
    if (lastName != null && lastName != _lastName) {
      _lastName = lastName;
      await _storage.setValue('profile_last_name', lastName);
    }
    if (positionName != null && positionName != _positionName) {
      _positionName = positionName;
      await _storage.setValue('profile_position_name', positionName);
    }
    if (imagesFile != null && imagesFile != _imagesFile) {
      _imagesFile = imagesFile;
      await _storage.setValue('profile_images_file', imagesFile);
    }
    if (logoImage != null && logoImage != _logoImage) {
      _logoImage = logoImage;
      await _storage.setValue('profile_logo_image', logoImage);
    }
    if (colorCode != null && colorCode != _colorCode) {
      _colorCode = colorCode;
      await _storage.setValue('profile_color_code', colorCode);
    }
    notifyListeners();
  }

  @override
  Future<void> clear() async {
    _firstName = '';
    _lastName = '';
    _positionName = '';
    _imagesFile = '';
    _logoImage = '';
    _colorCode = '';
    notifyListeners();
  }
}