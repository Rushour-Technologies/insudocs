import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insudox_app/classes/policy_model.dart';

import 'package:insudox_app/drawer/components/drawer_card_field.dart';
import 'package:insudox_app/globals.dart';
import 'package:path_provider/path_provider.dart';

class RequestsInfoCard extends StatefulWidget {
  const RequestsInfoCard({Key? key, required this.policy}) : super(key: key);

  /// The policy information to be displayed
  final PolicyModel policy;

  @override
  State<RequestsInfoCard> createState() => _RequestsInfoCardState();
}

class _RequestsInfoCardState extends State<RequestsInfoCard> {
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    FlutterDownloader.registerCallback(TestClass.callback);

    Future<void> downloadFile(String url) async {
      Directory downloadDir = await getExternalStorageDirectory() ??
          await getApplicationSupportDirectory();
      print(downloadDir.path);
      final res = await FlutterDownloader.enqueue(
        url: url,
        savedDir: downloadDir.path,
        saveInPublicStorage: true,
        headers: {
          "title": "Documents",
        },
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
      print(res);
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      color: GlobalColor.fourth,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            drawerCardField(
              "Insurance Type",
              widget.policy.insuranceType.name,
              screenHeight,
              screenWidth,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: drawerCardField(
                "Insurance Service",
                widget.policy.insuranceStatus.name,
                screenHeight,
                screenWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: drawerCardField(
                "Comapny name",
                widget.policy.insuranceCompanyName,
                screenHeight,
                screenWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: drawerCardField(
                "Request Status",
                widget.policy.requestStatus.name,
                screenHeight,
                screenWidth,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: Text(
                  "Download Uploaded Docs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Download files from firebase storage link
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Downloading..."),
                      ),
                    );
                    isDownloading = true;
                    setState(() {
                      print(isDownloading);
                    });
                    for (var url in widget.policy.uploadedFilesUrl) {
                      downloadFile(url);
                    }
                    print(isDownloading);
                    isDownloading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Downloaded"),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Text("Download"),
                      (isDownloading)
                          ? Icon(Icons.downloading_rounded)
                          : Icon(Icons.download_outlined)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TestClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}
