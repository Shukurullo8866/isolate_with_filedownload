import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_with_filedownload/cubit/notification_cubit/notificatio_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/download_data.dart';
import '../../utils/my_utils.dart';
import 'file_download_state.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit()
      : super(
          const FileManagerState(
              progress: 0.0, newFileLocation: "", stop: true),
        );
  void stopped({required bool stopped, stop}) async {
    stop == stopped;
  }

   downloadFile({required FileInfo file})  async {
    await Isolate.run( await downloadIfExis(fileInfo: file));
    Isolate.exit();
  }
  downloadIfExis({required FileInfo fileInfo, stop}) async {
    if (stop == false) {
      MyUtils.getMyToast(message: "Yuklash jarayoni tugadi");
    }else{

      Dio dio = Dio();
      var directory = await getDownloadPath();
      print("Path: ${directory?.path}");
      String url = fileInfo.fileUrl;
      String newFileLocation =
          "${directory?.path}/${fileInfo.fileName}${DateTime.now().microsecond}${url.substring(url.length - 5, url.length)}";
      try {
       NotificationCubit().sendNotification();
        await dio.download(url, newFileLocation,
            onReceiveProgress: (received, total) {
              var pr = received / total;
              if(received == total){
                NotificationCubit().sendNotification(isFinished: true);
              }
              emit(state.copyWith(progress: pr));
            });


        emit(state.copyWith(newFileLocation: newFileLocation));
      } catch (error) {
        debugPrint("Download Error:$error");
      }

    }
  }
  }


Future<bool> _requestWritePermission() async {
  await Permission.storage.request();
  return await Permission.storage.request().isDenied;
}

Future<Directory?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (err) {
    debugPrint("Cannot get download folder path");
  }
  return directory;
}
