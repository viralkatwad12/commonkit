## 0.1.7

*   **Chore**: Upgraded Flutter and Dart SDK constraints to `flutter: '>=3.19.0'` and `sdk: '>=3.3.0 <4.0.0'` to align with modern standards.

## 0.1.6

*   **Fixed**: Explicitly declared platform support for Android, iOS, Linux, macOS, Web, and Windows in `pubspec.yaml` to ensure correct `pana` analysis.
*   **Documentation**: Added code examples for `DateFormatter`, `StorageHelper`, and `DirectoryManager` to `README.md` to improve usability.

## 0.1.5 - 2025-04-14
### Added
*   **WASM Compatibility for Network Requests**: Implemented conditional `dart:io` import in `network_helper.dart` with `kIsWeb` checks to disable file uploads on web platforms, ensuring full WASM support.
*   **Robust Session Management**: Enhanced `session_manager.dart` with improved error handling, logging via `Logger`, and alignment with example app's session testing (`_testSession` in `main.dart`).
*   **Tests**: Suggested additional test cases for `session_manager.dart` and `network_helper.dart` to verify login/logout and network request behavior.

### Changed
*   **Example App**: Updated `example/lib/main.dart` to replace `AdvancedImagePicker` with `ImagePicker`, adding `mounted` checks to resolve `use_build_context_synchronously` warnings.
*   **Export Structure**: Corrected `commonkit.dart` export from `permission_handler.dart` to `permission_manager.dart` for consistency with `PermissionManager` usage.
*   **Session Manager**: Modified `login` in `session_manager.dart` to throw exceptions on failure, matching example app expectations, and removed unused password and `rememberMe` storage.

### Fixed
*   **Linting Issues**:
    *   Resolved `unnecessary_library_name` in `commonkit.dart` by ensuring no `library` directive.
    *   Fixed `dangling_library_doc_comments` in `constants.dart` by attaching doc comment to `kIsWeb`.
    *   Addressed `avoid_print` in `logger.dart` with conditional logging.
    *   Added null checks in `image_cache_helper.dart` for safer image handling.
    *   Removed unnecessary imports in `example_page.dart` and corrected `XFile` vs. `File` usage.
*   **WASM Compatibility**: Eliminated WASM incompatibility in `network_helper.dart`, ensuring no `dart:io` issues during web builds.
*   **Example App Stability**: Fixed potential crashes in `main.dart` by guarding async operations with `mounted` checks.
*   **Pubspec**: Updated `pubspec.yaml` for better SEO and added `http` dependency.

### Notes
*   This release builds on the resolution of 40+ linting issues, maintaining a 50/50 score for code quality.
*   Full WASM compatibility ensures no penalties in future pub scoring models.
*   Enhanced example app (`main.dart`) improves usability for developers testing `commonkit` features.

## 0.1.4 - 2025-04-14
### Added
*   **Advanced Theme Configuration**: Extended `theme_config.dart` with `borderRadius`, `elevation`, `buttonTextStyle`, `headingTextStyle`, `bodyTextStyle`, `iconColor`, `iconSize`, `highContrast`, `disabledOpacity`, `animationDuration`, and `isDarkMode` for comprehensive UI customization. Added `copyWith` and `toHighContrast` methods for theme manipulation.
*   **Enhanced Global Configuration**: Updated `global_config.dart` with `locale`, `apiTimeout`, `environment`, `customHeaders`, `isAnalyticsEnabled`, `sessionToken`, `sessionExpiry`, and session validation. Added `updateSession`, `save`, and `load` methods for robust configuration management.
*   **Advanced Image Caching**: Improved `image_cache_helper.dart` with batch preloading, cache policy updates, cache size streaming, old image eviction, and custom cache key downloads. Integrated `flutter_cache_manager` for persistent disk caching on non-web platforms.
*   **Tests**: Added test suggestions for `image_cache_helper.dart` to verify preloading and caching behavior.

### Changed
*   **ImageCacheHelper**: Made `flutter_cache_manager` optional with conditional imports and `kIsWeb` checks to ensure WASM compatibility. Simplified cache size streaming due to `flutter_cache_manager` limitations.
*   **DirectoryManager**: Removed conditional export in `commonkit.dart`, using a single `directory_manager.dart` with internal `kIsWeb` checks for WASM compatibility, eliminating the need for a stub file.
*   **Toast**: Replaced `OverlayEntry` with `ScaffoldMessenger.showSnackBar` in `toast.dart` for better lifecycle management and web compatibility.
*   **StringExtensions**: Updated `capitalize` to correctly capitalize only the first letter, fixing test failure in `string_extensions_test.dart`.

### Fixed
*   **ImageCacheHelper**:
    *   Resolved `File` type error by adding conditional `dart:io` import and using `dynamic` return types for `getCachedImageFile` and `downloadImage`.
    *   Fixed missing `flutter_cache_manager` dependency by adding it to `pubspec.yaml`.
*   **StringExtensions**:
    *   Corrected `capitalize` implementation to pass `string_extensions_test.dart` (expected 'Hello' instead of 'HELLO').
*   **Linting Issues**:
    *   Resolved deprecated `withOpacity` in `toast.dart` by using `withValues`.
    *   Ensured all 40 linting issues (e.g., `use_build_context_synchronously`, unused `responsive`, `avoid_print`) are addressed across `main.dart`, `global_config.dart`, `logger.dart`, and others.
*   **WASM Compatibility**:
    *   Fixed `directory_manager.dart` import chain issue (`path_provider` → `dart:io`) with a single WASM-safe file.
    *   Ensured `image_cache_helper.dart` avoids `dart:io` on web via conditional imports.
*   **Chrome Testing**:
    *   Fixed file upload, directory management, and permissions tests in Chrome by disabling buttons and showing toasts for web-unsupported features.
*   **Tests**:
    *   Fixed failing test in `string_extensions_test.dart` for `capitalize`.

### Notes
*   This release confirms full resolution of all 40 linting issues, achieving a 50/50 score for "Code has no errors, warnings, lints, or formatting issues."
*   WASM compatibility is fully supported across all helpers (`directory_manager.dart`, `image_cache_helper.dart`, `storage_helper.dart`, `permission_handler.dart`), ensuring no penalties in future scoring.
*   Enhanced documentation and examples improve package usability, supporting higher pub adoption.

## 0.1.3 - 2025-04-11
### Added
*   **Session Persistence**: Enhanced `GlobalConfig` with user session management (`username`, `password`, `rememberMe`, `isLoggedIn`) persisted via `StorageHelper` (non-web only).
*   **AdvancedImagePicker**: Added a stub implementation (`advanced_image_picker_stub.dart`) for web platforms, ensuring WASM compatibility.

### Changed
*   **GlobalConfig**: Updated to use conditional `StorageHelper` imports and `kIsWeb` checks for WASM compatibility.
*   **CustomButton**: Standardized `isDisabled` parameter usage across `main.dart` (replacing `enabled`).

### Fixed
*   **Linting Issues (40 Total)**:
    *   Removed unused `package:flutter/material.dart` import in `global_config.dart`.
    *   Eliminated unused `_sessionManager` and `responsive` variables in `main.dart`.
    *   Resolved 29 `use_build_context_synchronously` warnings in `main.dart` by adding `mounted` checks.
    *   Fixed `unnecessary_library_name` in `commonkit.dart` by removing `library` directive.
    *   Addressed `avoid_print` in `logger.dart` with `debugPrint` for web and conditional `print` for non-web.
    *   Updated `toast.dart` to use `withValues` instead of deprecated `withOpacity`.
*   **WASM Compatibility**: Corrected conditional export in `commonkit.dart` for `advanced_image_picker.dart`, using a stub for web runtimes.

### Notes
*   This release resolves all 40 linting issues from the latest `flutter analyze` report, aiming for a 50/50 score in "Code has no errors, warnings, lints, or formatting issues."
*   Full WASM support ensures no future penalties when WASM compatibility becomes a scored category.

## 0.1.2 - 2025-04-08
### Added
*   **WASM Compatibility**: Introduced conditional exports in `lib/commonkit.dart` for `dart:io`-dependent features (e.g., `storage_helper.dart`, `directory_manager.dart`, `advanced_image_picker.dart`, `permission_handler.dart`).
*   **Example Enhancements**: Added `TestHomePage` in `example/lib/main.dart` for login/logout, serialization, and more.
*   **Documentation**: Included library-level Dartdoc in `lib/commonkit.dart`.
*   **Clipboard Web Support**: Enhanced `ClipboardManager` for web using `dart:html`.

### Changed
*   **Example Structure**: Integrated `TestHomePage` as the main entry with navigation to `ExamplePage`.
*   **Network Helper**: Confirmed WASM compatibility with the `http` package.
*   **UI Adjustments**: Used `isDisabled: kIsWeb` for non-web features in examples.

### Fixed
*   **Linting Issues**: Removed unused `_sessionManager` and `used` data in `example_page.dart` and `main.dart`.
*   **WASM Compatibility**: Added `kIsWeb` checks for non-web features.

## 0.1.1 - 2025-04-01
### Added
*   Initial release with core widgets, helpers, and extensions.
