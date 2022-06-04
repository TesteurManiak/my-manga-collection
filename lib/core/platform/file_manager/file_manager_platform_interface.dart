part of 'file_manager.dart';

abstract class FileManagerPlatform {
  static FileManagerPlatform instance = FileManagerPlatformException();

  /// Write [data] inside [fileName] to [path] and return the path to the file.
  ///
  /// - `fileName`: The name of the file (e.g: `my_file.json`).
  /// - `data`: The data to write inside the file.
  Future<String> writeFile({
    required String fileName,
    required String data,
  }) {
    throw UnimplementedError('writeFile() has not been implemented.');
  }
}

class FileManagerPlatformException extends FileManagerPlatform {}
