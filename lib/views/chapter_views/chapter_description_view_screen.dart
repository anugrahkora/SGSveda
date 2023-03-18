import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:veda_nidhi_v2/models/get_chapters_model.dart';
import 'package:veda_nidhi_v2/utils/validate_data_utils.dart';

import '../../utils/constants.dart';

class ChapterDescriptionViewScreen extends StatefulWidget {
  final Chapter chapter;
  final String?  fileId;
  const ChapterDescriptionViewScreen(
      {super.key, required this.chapter, required this.fileId});

  @override
  State<ChapterDescriptionViewScreen> createState() =>
      _ChapterDescriptionViewScreenState();
}

class _ChapterDescriptionViewScreenState
    extends State<ChapterDescriptionViewScreen> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(ValidateDataUtils.validateString(widget.chapter.name)),
          backgroundColor: const Color(0xfff4f4f6),
          elevation: 0,
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(
          //       Icons.bookmark,
          //       color: Color(0xffff6933),
          //       semanticLabel: 'Bookmark',
          //     ),
          //     onPressed: () {
          //       _pdfViewerKey.currentState?.openBookmarkView();
          //     },
          //   ),
          // ],
        ),
        body: const PDF().cachedFromUrl(
          
          
          "$baseUrl/assets/${widget.fileId}",
          placeholder: (progress) => Center(
            child: SizedBox(
              height: size.height * 0.2,
              width: size.height * 0.2,
              child: LiquidCircularProgressIndicator(
                value: progress/100, // Defaults to 0.5.
                valueColor: const AlwaysStoppedAnimation(Color(
                    0xffff6933)), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors
                    .white, // Defaults to the current Theme's backgroundColor.
                borderColor: const Color(0xffff6933),
                borderWidth: 1,
                direction: Axis
                    .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                center: Text(
                  "${(progress.truncate()).toString()}%",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          errorWidget: (error) => Center(child: Text(error.toString())),
        )
        // SfPdfViewer.network(

        //   "$baseUrl/assets/${widget.fileId}",
        //   key: _pdfViewerKey,
        // ),
        );
  }
}
