import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart' as path;

part 'camera_capture_event.dart';

part 'camera_capture_state.dart';

class CameraCaptureBloc extends Bloc<CameraCaptureEvent, CameraCaptureState> {
  CameraCaptureBloc() : super(CameraCaptureInitial()) {
    on<InitCamera>((event, emit) async {
      emit(CameraCaptureLoading());
      if (_cameraController == null) {
        await availableCameras().then((cameras) {
          return cameras.first;
        }).then((rearCamera) {
          return CameraController(
            rearCamera,
            ResolutionPreset.veryHigh,
            enableAudio: false,
            imageFormatGroup: Platform.isIOS
                ? ImageFormatGroup.bgra8888
                : ImageFormatGroup.jpeg,
          );
        }).then((controller) {
          _cameraController = controller;
        }).then((_) async {
          await _cameraController!.initialize();
          _cameraController!.setFlashMode(FlashMode.off);
        }).whenComplete(() {
          emit(CameraCaptureLoaded());
        });
      }
    });
    on<CaptureImage>((event, emit) async {
      emit(CameraCaptureLoading());

      /// Prepare file image
      final docDir = await path.getApplicationDocumentsDirectory();
      final targetDir = '${docDir.path}/Picture';
      Directory(targetDir).create(recursive: true);

      /// Handle camera take image
      await _cameraController!.takePicture().then((cameraImageFile) async {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final currentFilePath = cameraImageFile.path;

        /// xx/xxx/xx/wrhwrhwr.jpg
        final currentFileName = currentFilePath.split('/').last;
        final ext = currentFileName.split('.').last;
        final fileName = '$timestamp.$ext';

        final file = File('$targetDir/$fileName');
        final imageBytes = await cameraImageFile.readAsBytes();
        return await file.writeAsBytes(imageBytes);
      }).then((file) {
        _cameraController!.pausePreview();
        _capturedImage = file;
        emit(CameraCaptureSuccess(file));
      });
    });
    on<ClearImage>((event, emit) {
      emit(CameraCaptureLoading());
      _cameraController!.resumePreview();
      if (_capturedImage != null) {
        _capturedImage!.delete(recursive: true);
      }

      emit(CameraCaptureLoaded());
    });
    on<ConfirmImage>((event, emit) {
      emit(CameraCaptureLoading());
      emit(CameraCaptureConfirmed(_capturedImage!));
    });
  }

  CameraController? _cameraController;

  File? _capturedImage;

  CameraController? get cameraController => _cameraController;
}
