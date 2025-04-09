import '../config/global_config.dart';
import 'network_helper.dart';

/// A utility class to manage user session states (login/logout).
class SessionManager {
  final NetworkHelper _networkHelper;

  /// Constructor requiring a NetworkHelper instance.
  SessionManager({NetworkHelper? networkHelper})
      : _networkHelper = networkHelper ?? NetworkHelper();

  /// Logs in a user with [username] and [password], optionally remembering them.
  Future<bool> login({
    required String username,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // Simulate a login request (replace with real API endpoint)
      final response = await _networkHelper.post(
        '/login', // Hypothetical endpoint
        body: {'username': username, 'password': password},
      );
      if (response['success'] == true) { // Adjust based on real API response
        GlobalConfig().username = username;
        GlobalConfig().password = password;
        GlobalConfig().rememberMe = rememberMe;
        GlobalConfig().isLoggedIn = true;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Logs out the current user.
  Future<void> logout() async {
    try {
      // Simulate a logout request (replace with real API endpoint)
      await _networkHelper.post('/logout');
    } finally {
      GlobalConfig().isLoggedIn = false;
      if (!GlobalConfig().rememberMe) {
        GlobalConfig().username = null;
        GlobalConfig().password = null;
      }
    }
  }

  /// Checks if the user is currently logged in.
  bool isLoggedIn() => GlobalConfig().isLoggedIn;
}