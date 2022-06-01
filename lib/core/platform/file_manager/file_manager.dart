import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';

part 'file_manager_android.dart';
part 'file_manager_exceptions.dart';
part 'file_manager_ios.dart';
part 'file_manager_platform_interface.dart';

class FileManager {
  static bool _manualRegistrationNeeded = true;

  FileManager._();

  factory FileManager() {
    _singleton ??= FileManager._();
    return _singleton!;
  }

  static FileManager? _singleton;

  static FileManagerPlatform get _platform {
    if (_manualRegistrationNeeded) {
      if (!kIsWeb &&
          FileManagerPlatform.instance is FileManagerPlatformException) {
        if (io.Platform.isAndroid) {
          FileManagerPlatform.instance = FileManagerAndroid();
        } else if (io.Platform.isIOS) {
          FileManagerPlatform.instance = FileManagerIOS();
        }
      }
      _manualRegistrationNeeded = false;
    }
    return FileManagerPlatform.instance;
  }

  /// Write [data] inside [fileName] and return the path to the file.
  Future<String> writeFile({
    required String fileName,
    required String data,
  }) =>
      _platform.writeFile(
        fileName: fileName,
        data: data,
      );
}

final fileManagerProvider = Provider<FileManager>((_) => FileManager());
