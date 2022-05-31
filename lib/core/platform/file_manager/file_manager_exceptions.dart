part of 'file_manager.dart';

class FileManagerException implements Exception {
  final String message;

  FileManagerException(this.message);

  @override
  String toString() => message;
}
