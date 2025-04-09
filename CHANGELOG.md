# Changelog

All notable changes to the `commonkit` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2025-04-08

### Added
- **WASM Compatibility**: Added conditional exports in `lib/commonkit.dart` to support WebAssembly (WASM) runtime by excluding `dart:io`-dependent features on web platforms (e.g., `storage_helper.dart`, `directory_manager.dart`, `advanced_image_picker.dart`, `permission_handler.dart`).
- **Example Enhancements**: Expanded the `example/lib/main.dart` with a new `TestHomePage` demonstrating login/logout, serialization, and additional `commonkit` features, alongside the existing `ExamplePage`.
- **Documentation**: Added library-level Dartdoc comments to `lib/commonkit.dart` to improve pub score documentation coverage.
- **Clipboard Web Support**: Enhanced `ClipboardManager` to work on web using `dart:html` for WASM compatibility.

### Changed
- **Example Structure**: Updated `example/lib/main.dart` to integrate `TestHomePage` as the main entry point, with navigation to `ExamplePage`, providing a more comprehensive demo of `commonkit` capabilities.
- **Network Helper**: Ensured `NetworkHelper` uses the `http` package, making it WASM-compatible by default.
- **UI Adjustments**: Added `enabled: !kIsWeb` to `CustomButton` widgets for file upload, directory management, and permission requests in `example_page.dart` and `main.dart`, disabling them on web with fallback messages.

### Fixed
- **Linting Issues**: Resolved unused variable warnings in `example_page.dart`:
    - Removed unused `_sessionManager` field since it wasn’t utilized.
    - Used the `data` variable in `_testFileUpload` by incorporating it into the status message.
- **Linting Issues in Main**: Fixed unused `data` in `main.dart`’s `_testFileUpload` by logging it with `Logger`.
- **WASM Compatibility**: Added `kIsWeb` checks and conditional imports throughout `example_page.dart` and `main.dart` to gracefully handle non-web features (file upload, directory management, permissions) on WASM.

### Notes
- This release prepares `commonkit` for future pub scoring models that will penalize WASM incompatibility.
- Remaining linting issues (up to 31 reported) should be addressed in future updates; only 2 were explicitly fixed here based on provided details.
- Full WASM support for file operations (e.g., web-based file picker) is not yet implemented but can be added in future versions.

## [0.1.1] - [Previous Release Date]
- Initial release with core widgets, helpers, and extensions (details assumed as no prior changelog provided).

---

### Instructions
1. **Create the File**: Place this `CHANGELOG.md` in the root of your `commonkit` package directory:
