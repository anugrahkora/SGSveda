
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class OpenPdfFromAssetsViewScreen extends StatelessWidget {
  final String filePath;
  const OpenPdfFromAssetsViewScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: SfPdfViewer.file(
      //     File(filePath),
      //   ),
      // ),
      body: PDF(
        onError: (error) {
          Center(
            child: Column(
              children: [
                Text(
                  'Ooops!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Falied to open PDF',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(error.toString()),
              ],
            ),
          );
        },
      ).fromPath(filePath),
    );
  }
}
