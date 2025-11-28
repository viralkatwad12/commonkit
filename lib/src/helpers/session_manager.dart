import 'dart:async';
import 'storage_helper.dart';

/// A singleton class to manage user session data, including login state and user credentials.
class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  String? _token;
  String? _userId;
  bool _isLoggedIn = false;

  final StreamController<bool> _sessionController = StreamController<bool>.broadcast();

  /// A stream that emits the login state (true for logged in, false for logged out).
  /// Useful for updating UI based on session changes.
  Stream<bool> get sessionStream => _sessionController.stream;

  /// Initializes the SessionManager and loads any persisted session data.
  /// Should be called on app startup.
  Future<void> init() async {
    await StorageHelper.init(); // Ensure storage is ready
    _token = await StorageHelper.read('token') as String?;
    _userId = await StorageHelper.read('userId') as String?;
    _isLoggedIn = _token != null;
    _sessionController.add(_isLoggedIn);
  }

  String? get token => _token;
  String? get userId => _userId;
  bool get isLoggedIn => _isLoggedIn;

  /// Creates a new session, storing the user token and ID.
  /// Emits the new login state to the session stream.
  Future<void> login(String token, String userId) async {
    _token = token;
    _userId = userId;
    _isLoggedIn = true;

    await StorageHelper.write('token', token);
    await StorageHelper.write('userId', userId);

    _sessionController.add(true);
  }

  /// Clears all session data and logs the user out.
  /// Emits the new login state to the session stream.
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _isLoggedIn = false;

    await StorageHelper.clear(); // Clears all persisted data

    _sessionController.add(false);
  }

  /// Disposes of the session stream controller.
  /// Should be called when the app is permanently shutting down.
  void dispose() {
    _sessionController.close();
  }
}
