# CommonKit

A lightweight, reusable utility package for Flutter apps, providing a collection of widgets, helpers, and extensions to simplify common development tasks.

[![Pub Version](https://img.shields.io/pub/v/commonkit)](https://pub.dev/packages/commonkit)

## Features

### Widgets
- **LoadingOverlay**: Show a loading spinner with customizable theme.
- **CustomSnackbar**: Display styled snackbars with icons and colors.
- **CustomButton**: Create reusable buttons with text, icons, and themes.
- **Toast**: Show short-lived notifications at the screen bottom.
- **CustomDialog**: Present customizable dialogs with themed buttons.

### Extensions
- **StringExtensions**: Add `capitalize()` and `truncate()` to strings.
- **ContextExtensions**: Access `screenWidth`, `screenHeight`, and more.

### Helpers
- **Validators**: Validate form fields (e.g., email, required).
- **DateFormatter**: Format dates and get "time ago" strings.
- **NetworkHelper**: Simplify HTTP GET/POST with file upload support.
- **ImageCacheHelper**: Preload images for performance.
- **Debouncer**: Delay function calls for input debouncing.
- **StorageHelper**: Store key-value pairs persistently.
- **AnimationHelper**: Create fade and slide animations easily.
- **ResponsiveHelper**: Build responsive layouts with breakpoints.
- **SessionManager**: Manage login/logout with global state.
- **DirectoryManager**: Handle local file system operations (create, update, delete, list).
- **Logger**: Log messages with info, warning, and error levels.
- **ClipboardManager**: Copy/paste text to/from the clipboard.
- **DataSerializer**: Serialize/deserialize JSON data.
- **PermissionManager**: Request and check app permissions.

### Configuration
- **CommonKitTheme**: Define app-wide colors and styles.
- **GlobalConfig**: Manage global settings like base URL and user session.

## Example

The `example` directory contains a sample app demonstrating all features. The `ExamplePage` in `example/lib/example_page.dart` provides a dedicated interface to test key utilities like network requests, file uploads, directory management, clipboard, and permissions.

## Getting Started

Add CommonKit to your `pubspec.yaml`:

```yaml
dependencies:
  commonkit: ^0.1.0  # Use the latest version from pub.dev