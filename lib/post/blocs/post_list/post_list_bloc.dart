import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instaclone/post/model/post.dart';
import 'package:instaclone/post/post_repository.dart';

part 'post_list_event.dart';

part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc() : super(PostListInitial()) {
    on<GetPosts>((event, emit) async {
      emit(PostListLoading());
      await postRepository.all().then((posts) {
        allPost
          ..clear()
          ..addAll(posts);
        emit(PostListLoaded([]));
      }).onError((error, stackTrace) {
        emit(PostListLoaded([]));
      });
    });

    on<UpdatePost>((event, emit) {
      emit(PostListUpdated());
      print('Update Post Triggered');
      final postIndex = allPost.indexWhere((e) => e.id == event.post.id);
      if (postIndex != -1) {
        allPost[postIndex] = event.post;
      }
      emit(PostListLoaded([]));
    });
  }

  final postRepository = PostRepository();
  final List<Post> allPost = <Post>[];
}
