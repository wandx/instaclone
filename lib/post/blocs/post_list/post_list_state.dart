part of 'post_list_bloc.dart';

abstract class PostListState extends Equatable {
  const PostListState();
}

class PostListInitial extends PostListState {
  @override
  List<Object> get props => [];
}

class PostListLoading extends PostListState {
  @override
  List<Object> get props => [];
}

class PostListLoaded extends PostListState {
  final List<Post> posts;

  PostListLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}
