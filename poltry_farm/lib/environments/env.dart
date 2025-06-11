final class PfEnv {
  // This class holds the Firebase configuration options for different platforms.

  // Web
  static const String webApiKey = String.fromEnvironment('WEB_API_KEY');
  static const String webAppId = String.fromEnvironment('WEB_APP_ID');
  static const String webMessagingSenderId =
      String.fromEnvironment('WEB_MESSAGING_SENDER_ID');
  static const String webProjectId = String.fromEnvironment('WEB_PROJECT_ID');
  static const String webAuthDomain = String.fromEnvironment('WEB_AUTH_DOMAIN');
  static const String webStorageBucket =
      String.fromEnvironment('WEB_STORAGE_BUCKET');
  static const String webMeasurementId =
      String.fromEnvironment('WEB_MEASUREMENT_ID');

  // Android
  static const String androidApiKey = String.fromEnvironment('ANDROID_API_KEY');
  static const String androidAppId = String.fromEnvironment('ANDROID_APP_ID');
  static const String androidMessagingSenderId =
      String.fromEnvironment('ANDROID_MESSAGING_SENDER_ID');
  static const String androidProjectId =
      String.fromEnvironment('ANDROID_PROJECT_ID');
  static const String androidStorageBucket =
      String.fromEnvironment('ANDROID_STORAGE_BUCKET');
  // IOS
  static const String iosApiKey = String.fromEnvironment('IOS_API_KEY');
  static const String iosAppId = String.fromEnvironment('IOS_APP_ID');
  static const String iosMessagingSenderId =
      String.fromEnvironment('IOS_MESSAGING_SENDER_ID');
  static const String iosProjectId = String.fromEnvironment('IOS_PROJECT_ID');
  static const String iosStorageBucket =
      String.fromEnvironment('IOS_STORAGE_BUCKET');
  static const String iosBundleId = String.fromEnvironment('IOS_BUNDLE_ID');
  // MACOS
  static const String macOsApiKey = String.fromEnvironment('MACOS_API_KEY');
  static const String macOsAppId = String.fromEnvironment('MACOS_APP_ID');
  static const String macOsMessagingSenderId =
      String.fromEnvironment('MACOS_MESSAGING_SENDER_ID');
  static const String macOsProjectId =
      String.fromEnvironment('MACOS_PROJECT_ID');
  static const String macOsStorageBucket =
      String.fromEnvironment('MACOS_STORAGE_BUCKET');
  static const String macOsBundleId = String.fromEnvironment('MACOS_BUNDLE_ID');
  // Windows
  static const String winApiKey = String.fromEnvironment('WIN_API_KEY');
  static const String winAppId = String.fromEnvironment('WIN_APP_ID');
  static const String winMessagingSenderId =
      String.fromEnvironment('WIN_MESSAGING_SENDER_ID');
  static const String winProjectId = String.fromEnvironment('WIN_PROJECT_ID');
  static const String winAuthDomain = String.fromEnvironment('WIN_AUTH_DOMAIN');
  static const String winStorageBucket =
      String.fromEnvironment('WIN_STORAGE_BUCKET');
  static const String winMeasurementId =
      String.fromEnvironment('WIN_MEASUREMENT_ID');
}
