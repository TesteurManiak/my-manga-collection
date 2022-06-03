part of 'file_manager.dart';

class FileManagerWeb extends FileManagerPlatform {
  @override
  Future<String> writeFile({
    required String fileName,
    required String data,
  }) async {
    final bytes = utf8.encode(data);
    final ext = fileName.split('.').last;
    final downloaded = await _downloadFile(
      bytes: Uint8List.fromList(bytes),
      name: fileName,
      type: ext,
    );
    return downloaded ? 'Downloads/$fileName' : '';
  }

  Future<bool> _downloadFile({
    required Uint8List bytes,
    required String name,
    required String type,
  }) async {
    try {
      final url = html.Url.createObjectUrlFromBlob(html.Blob([bytes], type));
      final htmlDocument = html.document;
      final anchor = htmlDocument.createElement('a') as html.AnchorElement;
      anchor.href = url;
      anchor.style.display = name;
      anchor.download = name;
      anchor.type = type;
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
