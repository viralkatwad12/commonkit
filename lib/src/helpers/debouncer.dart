import 'dart:async';

/// A utility class to debounce function calls.
/// Prevents rapid successive calls by delaying execution until a calm period.
class Debouncer {
  /// The delay duration before the action is executed.
  final Duration delay;

  /// Internal timer to manage debounce delays.
  Timer? _timer;

  /// Constructor for Debouncer.
  /// [delay] defaults to 500 milliseconds if not specified.
  Debouncer({this.delay = const Duration(milliseconds: 500)});

  /// Runs the [action] after the [delay] has elapsed since the last call.
  /// Cancels any previous pending action.
  void run(void Function() action) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(delay, action); // Set a new timer
  }

  /// Cancels any pending debounced action.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Disposes the debouncer by canceling the timer.
  void dispose() {
    cancel();
  }
}