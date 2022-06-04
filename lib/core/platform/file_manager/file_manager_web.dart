part of 'file_manager.dart';

class FileManagerWeb extends FileManagerPlatform {
  @override
  Future<String> writeFile({
    required String fileName,
    required String data,
  }) async {
    final bytes = utf8.encode(data);
    final splittedName = fileName.split('.');
    final name = splittedName[0];
    final type = splittedName[1].toMimeType();
    final downloaded = await _downloadFile(
      bytes: Uint8List.fromList(bytes),
      name: name,
      type: type,
    );
    return downloaded ? 'Downloads/$fileName' : '';
  }

  Future<bool> _downloadFile({
    required Uint8List bytes,
    required String name,
    required MimeType type,
  }) async {
    try {
      final url =
          html.Url.createObjectUrlFromBlob(html.Blob([bytes], type.blobType));
      final htmlDocument = html.document;
      final anchor = htmlDocument.createElement('a') as html.AnchorElement;
      anchor.href = url;
      anchor.style.display = name;
      anchor.download = name;
      anchor.type = type.blobType;
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
