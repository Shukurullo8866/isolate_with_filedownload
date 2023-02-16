import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_safe/open_file_safe.dart';

import '../../../cubit/file_download_cubit/file_download_cubit.dart';
import '../../../cubit/file_download_cubit/file_download_state.dart';
import '../../../utils/download_data.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key, required this.fileInfo}) : super(key: key);
  final FileInfo fileInfo;

  FileManagerCubit fileManagerCubit = FileManagerCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileManagerCubit,
      child: BlocBuilder<FileManagerCubit, FileManagerState>(
        builder: (context, state) {
          return ListTile(
            leading: state.newFileLocation.isEmpty
                ? IconButton(
                    onPressed: () {
                      if (state.progress == 0.0) {
                        context
                            .read<FileManagerCubit>()
                            .downloadIfExis(fileInfo: fileInfo);
                      } else if (state.progress > 0.0) {
                        context
                            .read<FileManagerCubit>()
                            .stopped(stopped: false);
                      }
                    },
                    icon: Icon(
                      Icons.download,
                      color: Colors.pink,
                    ))
                : const Icon(
                    Icons.download_done,
                    color: Colors.green,
                  ),
            title: Text(
              "${fileInfo.fileName}:                  ${state.progress * 100}%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            subtitle: LinearProgressIndicator(
              color: Colors.red,
              value: state.progress,
              backgroundColor: Colors.black,
            ),
            trailing: IconButton(
              onPressed: () {
                OpenFile.open(state.newFileLocation);
              },
              icon: const Icon(
                Icons.file_open,
                color: Colors.deepPurpleAccent,
              ),
            ),
          );
        },
      ),
    );
  }
}
