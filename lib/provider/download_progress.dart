import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProgress with ChangeNotifier {
  var _progress = 0.0;
  double get progress => _progress;

  void start({required String url, required String filename}) async {
    resetProgress();
    final directory = await getTemporaryDirectory();
    final pathName = "${directory.path}/$filename";

    await Dio().download(
      url,
      filename,
      options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          var pos = received / total * 100;
          updateProgress(pos);
        }
      },
    );
  }

  void resetProgress() {
    if (progress != 0) {
      _progress = 0;
      notifyListeners();
    }
  }

  void updateProgress(value) {
    _progress = value;
    notifyListeners();
  }
}
