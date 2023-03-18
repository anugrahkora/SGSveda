import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_nidhi_v2/widgets/snackbars.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';
import '../models/category_model.dart';
import '../models/get_chapters_model.dart';
import '../models/recent_books_model.dart';
import '../utils/constants.dart';
import '../views/chapter_views/chapter_description_view_screen.dart';
import 'get_image_from_url.dart';

class ChapterCardWidget extends StatefulWidget {
  final Chapter data;
  final String? fileNameDownload;
  final String? fileId;
  final Category category;
  const ChapterCardWidget(
      {super.key,
      required this.data,
      required this.category,
      required this.fileNameDownload,
      required this.fileId});

  @override
  State<ChapterCardWidget> createState() => _ChapterCardWidgetState();
}

class _ChapterCardWidgetState extends State<ChapterCardWidget> {
  double downloadProgress = 0.0;
  final _dio = Dio();

  Future download(String fileID, String fileNameDownload) async {
    String fullPath = '';
    var tempDir = await getApplicationDocumentsDirectory();
    final Directory appDocDirFolder = Directory('${tempDir.path}/$folderName/');
    if (await appDocDirFolder.exists()) {
      fullPath = appDocDirFolder.path;
    } else {
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      fullPath = appDocDirNewFolder.path;
    }
    // String fullPath = "${tempDir.path}/pdfs/";

    try {
      showBasicSnackbarWithoutCounter('Download started');
      final response = await _dio.get(
        "$baseUrl/assets/$fileID",
        onReceiveProgress: setDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      File file = File("$fullPath/$fileNameDownload");
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      showSuccess("Downloaded", "The File has been Downloaded to your Device");
    } catch (e) {
      showErrorFromCatch('error while downloading', e);
    }
  }

  void setDownloadProgress(received, total) {
    if (total != -1) {
      // print((received / total) + "%");
      setState(() {
        downloadProgress = received / total;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final downloadController = Get.put(DownloadController());
    Future<void> launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color(0xfff4f4f6),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        onTap: () async {
          if (widget.category.image != null && widget.category.name != null) {
            final book = RecentBooks(
                bookName: widget.category.name!,
                bookId: widget.category.id,
                bookImageId: widget.category.image!);
            recentsBox.addBook(book);
          }
          Get.to(() => ChapterDescriptionViewScreen(
                chapter: widget.data,
                fileId: widget.fileId,
              ));
        },
        leading: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: const Color(0xfffff0eb),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: widget.data.image != null
                ? getImageFromUrlLowRes(
                    //
                    url: widget.data.image!.filenameDisk)
                : const SizedBox(),
          ),
        ),
        iconColor: const Color(0xffff6933),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
            onPressed: () async {
              if (widget.data.playableUrl != null) {
                final Uri uri = Uri.parse(widget.data.playableUrl!);

                await launchInBrowser(uri);
              } else {
                showBasicSnackbarWithoutCounter("No Link added");
              }
            },
            icon: SvgPicture.asset(
              'assets/play_icon1.svg',
              height: 20,
              width: 20,
              color: const Color(0xff603183),
            ),
          ),
          IconButton(
            onPressed: () async {
              var status = await Permission.storage.request();
              if (status.isGranted &&
                  widget.fileId != null &&
                  widget.fileNameDownload != null) {
                await download(widget.fileId!, widget.fileNameDownload!);
              } else {
                showBasicSnackbarWithoutCounter('Cannot download');
              }
            },
            icon: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/download_icon1.svg',
                  height: 16,
                  width: 16,
                  color: const Color(0xffff6933),
                ),
                CircularProgressIndicator(
                  value: downloadProgress,
                  color: const Color(0xffff6933),
                ),
              ],
            ),
          ),
        ]),
        title: Text(
          widget.data.name ?? " ",
          maxLines: 2,
          style: const TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff141a39)),
        ),
      ),
    );
  }
}
