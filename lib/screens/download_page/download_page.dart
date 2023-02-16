import 'package:flutter/material.dart';
import 'package:isolate_with_filedownload/screens/download_page/second_page.dart';
import '../../../utils/download_data.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int doublePress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text("Download "),
      ),
      body: SizedBox(
        height: 700,
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
            filesData.length,
                (index) {
              var fileInfo = filesData[index];
              return SecondPage(fileInfo: fileInfo);
            },
          ),
        ),
      ),
    );
  }
}