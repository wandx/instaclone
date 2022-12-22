part of 'post_list_bloc.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();
}

class GetPosts extends PostListEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPosts extends PostListEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePost extends PostListEvent {
  final Post post;

  const UpdatePost(this.post);

  @override
  List<Object?> get props => [post];
}
