import 'dart:convert';
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
    final file = result?.files.single;
    if (file != null) {
      // Handle iOS specific case: https://github.com/miguelpruivo/flutter_file_picker/issues/1020
      if (!kIsWeb && io.Platform.isIOS) return _handleIOS(file);
      final byteData = file.bytes;
      if (byteData != null) {
        final decodedData = utf8.decode(byteData);
        return decodedData;
      }
    }
    return null;
  }

  Future<String?> _handleIOS(PlatformFile platformFile) async {
    final path = platformFile.path;
    if (path == null) return null;
    final file = io.File(path);
    return file.readAsString();
  }
}

final fileImportProvider = Provider<FileImport>((_) => FileImportImpl());
