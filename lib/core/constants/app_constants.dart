class AppConstants {
  static const String appName = 'HR Optimistic';
  
  // API Constants
  static const String baseUrl = 'YOUR_API_BASE_URL';
  static const int apiTimeout = 30000; // 30 seconds
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String languageKey = 'language';
  
  // Routes
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  
  // Timeouts
  static const int splashDelay = 2000; // 2 seconds
  static const int cacheTimeout = 7 * 24 * 60 * 60; // 7 days in seconds
  
  // Pagination
  static const int pageSize = 20;
  
  // Date Formats
  static const String defaultDateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'dd MMM yyyy';
  static const String timeFormat = 'HH:mm';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 20;
  static const int pinCodeLength = 6;
  
  // File Size Limits
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxAttachmentSize = 10 * 1024 * 1024; // 10MB
  
  // Cache Duration
  static const Duration cacheDuration = Duration(days: 7);
  
  // Animation Duration
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Error Messages
  static const String networkError = 'Please check your internet connection';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'An unexpected error occurred';
  
  private AppConstants._();
}