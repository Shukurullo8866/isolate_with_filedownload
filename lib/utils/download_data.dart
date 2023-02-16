
import 'package:equatable/equatable.dart';

class FileInfo extends Equatable {
  final String fileName;
  final String fileUrl;
  final double progres;

  FileInfo(
      {required this.fileName, required this.fileUrl, required this.progres});
  FileInfo copyWith({String? fileName, String? fileUrl, double? progres}) =>
      FileInfo(
          fileName: fileName ?? this.fileUrl,
          fileUrl: fileUrl ?? this.fileUrl,
          progres: progres ?? this.progres);

  @override
  List<Object?> get props => [
        fileName,
        fileUrl,
        progres,
      ];
}

List<FileInfo> filesData = [
  FileInfo(
      fileName: "Foto 1",
      fileUrl:
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
      progres: 0.0),
  FileInfo(
      fileName: "Foto 2",
      fileUrl:"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
      progres: 0.0),
  FileInfo(
      fileName: "Foto 3",
      fileUrl:
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4",
      progres: 0.0),
  FileInfo(
      fileName: "Foto 4",
      fileUrl:
      "https://cdn.pixabay.com/photo/2018/01/12/10/19/fantasy-3077928__480.jpg",
      progres: 0.0),
];
