part of 'file_manager.dart';

class FileManagerIOS extends FileManagerPlatform {
  @override
  Future<String> writeFile({
    required String fileName,
    required String data,
  }) async {
    final appDocumentsDirectory = await path.getApplicationDocumentsDirectory();
    final appDocumentsPath = appDocumentsDirectory.path;
    final filePath = '$appDocumentsPath/$fileName';

    final file = io.File(filePath);
    await file.writeAsString(data);
    return filePath;
  }
}
