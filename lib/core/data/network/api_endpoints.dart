class ApiEndPoints {
  // URLs
  final String _url = "http://localhost:7000/";
  final String _baseUrl = "http://localhost:7000/api/";

  // Private constructor for singleton pattern
  ApiEndPoints._privateConstructor();

  // Static instance of the class
  static final ApiEndPoints _instance = ApiEndPoints._privateConstructor();

  // Factory to return the singleton instance
  static ApiEndPoints get instance => _instance;

  // Accessor methods for the URLs
  static String get baseUrl => _instance._baseUrl;

  static String get url => _instance._url;

  // Authentication APIs
  static String get signUpUrl => '${baseUrl}users/registerUser';

  static String get signInUrl => '${baseUrl}auth/login';

  static String get departmentsUrl => '${baseUrl}departments';

  static String get jobUrl => '${baseUrl}jobs';

  static String get gradesUrl => '${baseUrl}grades';

  static String get positionUrl => '${baseUrl}positions';

  static String get locationsUrl => '${baseUrl}locations';

  static String get rolesUrl => '${baseUrl}roles';

  static String get permissionsUrl => '${baseUrl}permissions';

  static String get usersUrl => '${baseUrl}auth/users';

  static String get registerUserUrl => '${baseUrl}auth/register';

  static String get companiesUrl => '${baseUrl}companies';

  static String get businessUnitsUrl => '${baseUrl}business-units';
}
