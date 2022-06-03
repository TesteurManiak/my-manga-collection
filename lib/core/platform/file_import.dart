import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FileImport {
  /// Pick a file from the device file explorer and return its content as a
  /// [String].
  ///
  /// If the operation was cancelled or failed, return `null`.
  Future<String?> pickFile();
}

class FileImportImpl extends FileImport {
  @override
  Future<String?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final platformFile = result?.files.single;
    if (platformFile != null) {
      if (kIsWeb) return _handleWeb(platformFile);
      final path = platformFile.path;
      if (path == null) return null;
      final file = io.File(path);
      return file.readAsString();
    }
    return null;
  }

  Future<String?> _handleWeb(PlatformFile platformFile) async {
    // TODO: implement
    return null;
  }
}

final fileImportProvider = Provider<FileImport>((_) => FileImportImpl());
