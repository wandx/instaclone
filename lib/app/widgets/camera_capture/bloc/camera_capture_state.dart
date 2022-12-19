part of 'camera_capture_bloc.dart';

abstract class CameraCaptureState extends Equatable {
  const CameraCaptureState();
}

class CameraCaptureInitial extends CameraCaptureState {
  @override
  List<Object> get props => [];
}

class CameraCaptureLoading extends CameraCaptureState {
  @override
  List<Object> get props => [];
}

class CameraCaptureLoaded extends CameraCaptureState {
  @override
  List<Object> get props => [];
}

class CameraCaptureSuccess extends CameraCaptureState {
  final File image;

  const CameraCaptureSuccess(this.image);

  @override
  List<Object> get props => [image];
}

class CameraCaptureFailed extends CameraCaptureState {
  final String message;

  const CameraCaptureFailed(this.message);

  @override
  List<Object> get props => [message];
}

class CameraCaptureConfirmed extends CameraCaptureState {
  final File image;

  const CameraCaptureConfirmed(this.image);

  @override
  List<Object> get props => [image];
}
