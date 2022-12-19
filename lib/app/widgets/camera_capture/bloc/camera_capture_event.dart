part of 'camera_capture_bloc.dart';

abstract class CameraCaptureEvent extends Equatable {
  const CameraCaptureEvent();
}

class CaptureImage extends CameraCaptureEvent {
  @override
  List<Object?> get props => [];
}

class ClearImage extends CameraCaptureEvent {
  @override
  List<Object?> get props => [];
}

class ConfirmImage extends CameraCaptureEvent {
  @override
  List<Object?> get props => [];
}

class InitCamera extends CameraCaptureEvent {
  @override
  List<Object?> get props => [];
}
