part of 'file_manager.dart';

class FileManagerAndroid extends FileManagerPlatform {
  @override
  Future<String> writeFile({
    required String fileName,
    required String data,
    MimeType? type,
  }) async {
    if (await _requestPermission(Permission.storage)) {
      final appDocumentsDirectory = await path.getExternalStorageDirectory();
      final appDocumentsPath = appDocumentsDirectory!.path;
      final filePath = '$appDocumentsPath/$fileName';

      final file = io.File(filePath);
      await file.writeAsString(data);
      return filePath;
    } else {
      throw FileManagerException('Permission denied');
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result.isGranted;
    }
  }
}
