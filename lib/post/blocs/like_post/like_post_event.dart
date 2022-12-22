part of 'like_post_bloc.dart';

abstract class LikePostEvent extends Equatable {
  const LikePostEvent();
}

class LikePost extends LikePostEvent {
  final Post post;

  const LikePost(this.post);

  @override
  List<Object?> get props => [post];
}

class UnLikePost extends LikePostEvent {
  final Post post;

  const UnLikePost(this.post);

  @override
  List<Object?> get props => [post];
}

class ToggleLikePost extends LikePostEvent {
  final Post post;

  const ToggleLikePost(this.post);

  @override
  List<Object?> get props => [post];
}
