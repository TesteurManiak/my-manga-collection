import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FileManager {
  Future<String> writeFile({
    required String fileName,
    required String data,
  });
}

class FileManagerImpl implements FileManager {
  final FlutterFileSaver _fileSaver;

  FileManagerImpl({
    required FlutterFileSaver fileSaver,
  }) : _fileSaver = fileSaver;

  @override
  Future<String> writeFile({required String fileName, required String data}) =>
      _fileSaver.writeFileAsString(fileName: fileName, data: data);
}

final fileManagerProvider = Provider<FileManager>(
  (_) => FileManagerImpl(fileSaver: FlutterFileSaver()),
);
