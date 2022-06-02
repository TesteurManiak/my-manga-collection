part of 'file_manager.dart';

class FileManagerIOS extends FileManagerPlatform {
  @override
  Future<String> writeFile({
    required String fileName,
    required String data,
  }) async {
    // To find the file in the document folder I had to also set
    // `UISupportsDocumentBrowser`, `UIFileSharingEnabled` and
    // `LSSupportsOpeningDocumentsInPlace` to `YES` in the
    // `ios/Runner/info.plist`.
    final appDocumentsDirectory = await path.getApplicationDocumentsDirectory();
    final appDocumentsPath = appDocumentsDirectory.path;
    final filePath = '$appDocumentsPath/$fileName';

    final file = io.File(filePath);
    await file.writeAsString(data);
    return filePath;
  }
}
