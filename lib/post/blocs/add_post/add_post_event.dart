part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();
}

class SubmitAddPost extends AddPostEvent {
  @override
  List<Object?> get props => [];
}

class Initialize extends AddPostEvent {
  @override
  List<Object?> get props => [];
}
