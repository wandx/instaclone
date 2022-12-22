part of 'like_post_bloc.dart';

abstract class LikePostState extends Equatable {
  const LikePostState();
}

class LikePostInitial extends LikePostState {
  @override
  List<Object> get props => [];
}

class LikePostLoading extends LikePostState {
  @override
  List<Object> get props => [];
}

class LikePostSuccess extends LikePostState {
  final Post post;

  const LikePostSuccess(this.post);

  @override
  List<Object> get props => [post];
}

class LikePostFailed extends LikePostState {
  final String message;

  const LikePostFailed(this.message);

  @override
  List<Object> get props => [message];
}
