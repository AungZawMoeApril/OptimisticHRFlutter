class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://jarviz-api.azurewebsites.net/api/v6';

  // Timeouts
  static const int connectTimeout = 5; // seconds
  static const int receiveTimeout = 3; // seconds

  // Endpoints
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String verifyToken = '/auth/verify';
  static const String profile = '/users/profile';
  static const String attendance = '/attendance';
  static const String checkIn = '/attendance/check-in';
  static const String checkOut = '/attendance/check-out';
  static const String announcements = '/announcements';
  static const String leaves = '/leaves';
  static const String overtime = '/overtime';
}

class StorageKeys {
  static const String token = 'app_token';
  static const String refreshToken = 'app_refresh_token';
  static const String companyId = 'app_company_id';
  static const String employeeId = 'app_employee_id';
  static const String userId = 'app_user_id';
  static const String approve = 'app_approve';
  static const String locale = 'app_locale';
  static const String themeMode = 'app_theme_mode';
  static const String firstName = 'app_first_name';
  static const String lastName = 'app_last_name';
  static const String positionName = 'app_position_name';
  static const String imagesFile = 'app_images_file';
  static const String logoImage = 'app_logo_image';
  static const String colorCode = 'app_color_code';
}