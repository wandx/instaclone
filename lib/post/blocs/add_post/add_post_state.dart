part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();
}

class AddPostInitial extends AddPostState {
  @override
  List<Object> get props => [];
}

class AddPostLoading extends AddPostState {
  @override
  List<Object> get props => [];
}

class AddPostFailed extends AddPostState {
  final String message;

  const AddPostFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AddPostSuccess extends AddPostState {
  @override
  List<Object> get props => [];
}
