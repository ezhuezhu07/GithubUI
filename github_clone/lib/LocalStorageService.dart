import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService extends GetxService {
  late GetStorage userCred;
  late String appDirectory;

  LocalStorageService init() {
    userCred = GetStorage('UserCred');

    if (kIsWeb == false &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      // check and create the directory in device
      // To store the key value pair of data with GetStorage
      createAppDir();
    }
    return this;
  }

  createAppDir() async {
    const directoryName = 'GithubClone';
    final docDir = await getApplicationDocumentsDirectory();
    final myDir = Directory('${docDir.path}/$directoryName');

    if (await myDir.exists()) {
      appDirectory = myDir.path;
    } else {
      final dir = await myDir.create(recursive: true);
      appDirectory = dir.path;
    }
  }
}
