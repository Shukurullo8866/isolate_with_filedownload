import 'package:equatable/equatable.dart';

class FileManagerState extends Equatable {
  const FileManagerState(
      {required this.stop,
      required this.progress,
      required this.newFileLocation});
  final double progress;
  final String newFileLocation;
  final bool stop;

  FileManagerState copyWith({
    double? progress,
    String? newFileLocation,
    bool? stop,
  }) =>
      FileManagerState(
          stop: stop ?? this.stop,
          progress: progress ?? this.progress,
          newFileLocation: newFileLocation ?? this.newFileLocation);

  @override
  List<Object?> get props => [
        progress,
        newFileLocation,
        stop,
      ];
}
