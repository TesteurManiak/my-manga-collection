part of 'file_manager.dart';

abstract class FileManagerPlatform {
  static FileManagerPlatform instance = FileManagerPlatformException();

  Future<String> writeFile({
    required String fileName,
    required String data,
  }) {
    throw UnimplementedError('writeFile() has not been implemented.');
  }
}

class FileManagerPlatformException extends FileManagerPlatform {}
