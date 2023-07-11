import 'package:download_data/provider/download_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadWidget extends StatelessWidget {
  const DownloadWidget({super.key});
  final String url = "https://website.com/files/test.pdf";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<DownloadProgress>(
        builder: (context, value, child) {
          var progress = value.progress.toStringAsFixed(1);
          return ElevatedButton(
              onPressed: () {
                value.start(url: url, filename: "myfile.pdf");
              },
              child: Text("$progress %"));
        },
      ),
    );
  }
}
