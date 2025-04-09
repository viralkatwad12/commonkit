import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// A utility class to manage directories and files in the local file system.
/// Provides methods to create, update, delete, and list directory contents.
class DirectoryManager {
  /// Gets the app's default directory (e.g., temporary or documents directory).
  /// [useTemp] determines whether to use the temporary directory.
  Future<Directory> _getBaseDirectory({bool useTemp = false}) async {
    return useTemp
        ? await getTemporaryDirectory()
        : await getApplicationDocumentsDirectory();
  }

  /// Creates a directory at [path] relative to the base directory.
  /// Returns the created Directory object.
  Future<Directory> createDirectory(String path, {bool useTemp = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    final fullPath = '${baseDir.path}/$path';
    final directory = Directory(fullPath);
    if (!await directory.exists()) {
      return await directory.create(recursive: true);
    }
    return directory;
  }

  /// Creates a file at [filePath] with optional [content].
  /// Returns the created File object.
  Future<File> createFile(String filePath, {String? content, bool useTemp = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    final fullPath = '${baseDir.path}/$filePath';
    final file = File(fullPath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    if (content != null) {
      await file.writeAsString(content);
    }
    return file;
  }

  /// Updates the content of a file at [filePath].
  /// Returns the updated File object.
  Future<File> updateFile(String filePath, String content, {bool useTemp = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    final fullPath = '${baseDir.path}/$filePath';
    final file = File(fullPath);
    if (!await file.exists()) {
      throw Exception('File does not exist: $fullPath');
    }
    return await file.writeAsString(content);
  }

  /// Renames a directory or file from [oldPath] to [newPath].
  /// Returns the renamed Directory or File object.
  Future<dynamic> rename(String oldPath, String newPath, {bool useTemp = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    final oldFullPath = '${baseDir.path}/$oldPath';
    final newFullPath = '${baseDir.path}/$newPath';

    if (await Directory(oldFullPath).exists()) {
      final dir = Directory(oldFullPath);
      return await dir.rename(newFullPath);
    } else if (await File(oldFullPath).exists()) {
      final file = File(oldFullPath);
      return await file.rename(newFullPath);
    } else {
      throw Exception('Path does not exist: $oldFullPath');
    }
  }

  /// Deletes a directory or file at [path].
  Future<void> delete(String path, {bool useTemp = false, bool recursive = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    final fullPath = '${baseDir.path}/$path';

    if (await Directory(fullPath).exists()) {
      await Directory(fullPath).delete(recursive: recursive);
    } else if (await File(fullPath).exists()) {
      await File(fullPath).delete();
    }
  }

  /// Deletes all contents in the base directory.
  Future<void> deleteAll({bool useTemp = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    if (await baseDir.exists()) {
      await baseDir.delete(recursive: true);
      await baseDir.create(); // Recreate the base directory
    }
  }

  /// Lists all files and directories at [path].
  /// Returns a list of FileSystemEntity objects.
  Future<List<FileSystemEntity>> list(String path, {bool useTemp = false}) async {
    final baseDir = await _getBaseDirectory(useTemp: useTemp);
    final fullPath = '${baseDir.path}/$path';
    final directory = Directory(fullPath);
    if (!await directory.exists()) {
      throw Exception('Directory does not exist: $fullPath');
    }
    return directory.list(recursive: false).toList();
  }
}