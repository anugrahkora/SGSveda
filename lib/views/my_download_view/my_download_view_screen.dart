import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:veda_nidhi_v2/utils/constants.dart';
import 'package:veda_nidhi_v2/views/pdf_views/open_pdf_from_assets.dart';

class MyDownloadViewScreen extends StatefulWidget {
  const MyDownloadViewScreen({super.key});

  @override
  State<MyDownloadViewScreen> createState() => _MyDownloadViewScreenState();
}

class _MyDownloadViewScreenState extends State<MyDownloadViewScreen> {
  late Future<List<FileSystemEntity>> _future;
  @override
  void initState() {
    _future = getDir();
    super.initState();
  }

  Future<List<FileSystemEntity>> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/$folderName';
    final myDir = Directory(pdfDirectory);
  
    final folders = myDir.listSync(recursive: true);

    return folders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("My Download"),
        backgroundColor: const Color(0xfff4f4f6),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Downloads Empty',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'You don\'t have any downloaded items',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data![index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8.0),
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
                          Get.to(() =>
                              OpenPdfFromAssetsViewScreen(filePath: data.path));
                        },
                        leading: Stack(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: const Color(0xfffff0eb),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                              ),
                              child: SizedBox(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFF577F)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SvgPicture.asset(
                                    'assets/pdf_icon1.svg',
                                    // height: 18,
                                    // width: 18,
                                    color: const Color(0xffFF577F),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        iconColor: const Color(0xffff6933),
                        trailing: IconButton(
                          onPressed: () async {
                            _showRemoveDialog(context, data);
                          },
                          icon: SvgPicture.asset(
                            'assets/delete.svg',
                            height: 16,
                            width: 16,
                            color: const Color(0xffff6933),
                          ),
                        ),
                        title: Text(
                          data.path.split("/").last,
                          maxLines: 2,
                          style: const TextStyle(
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff141a39)),
                        ),
                      ),
                    );
                  },
                );
              }
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> _showRemoveDialog(
      BuildContext context, FileSystemEntity data) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Remove Item",
                style: Theme.of(context).textTheme.titleMedium),
            content: Text(
              "Are you sure, you want to Delete?",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Color.fromARGB(255, 131, 131, 131), fontSize: 13),
                ),
              ),
              TextButton(
                onPressed: () async {
                  data.deleteSync();
                  setState(() {
                    _future = getDir();
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color(0xFF26AE60), fontSize: 13),
                ),
              ),
            ],
          );
        });
  }
}
