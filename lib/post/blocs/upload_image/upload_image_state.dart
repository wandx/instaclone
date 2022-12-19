part of 'upload_image_cubit.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();
}

class UploadImageInitial extends UploadImageState {
  @override
  List<Object> get props => [];
}

class UploadImageLoading extends UploadImageState {
  @override
  List<Object> get props => [];
}

class UploadImageSuccess extends UploadImageState {
  final String fileUrl;

  const UploadImageSuccess(this.fileUrl);

  @override
  List<Object> get props => [fileUrl];
}

class UploadImageFailed extends UploadImageState {
  final String message;

  const UploadImageFailed(this.message);

  @override
  List<Object> get props => [message];
}
