import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/post/model/post.dart';
import 'package:instaclone/post/post_repository.dart';

part 'add_post_event.dart';

part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<SubmitAddPost>((event, emit) async {
      emit(AddPostLoading());
      final post = Post(
        uid: uidInput.text,
        imageUrl: imageUrlInput.text,
        caption: captionInput.text,
        avatarUrl: avatarInput.text,
        username: usernameInput.text,
      );
      await postRepository.create(post).then((value) {
        emit(AddPostSuccess());
      }).onError((error, stackTrace) {
        emit(AddPostFailed(error.toString()));
      });
    });

    on<Initialize>((event, emit) {
      final fa = FirebaseAuth.instance;
      final user = fa.currentUser;

      uidInput.text = user!.uid;
      usernameInput.text = user.email!;
      avatarInput.text = 'https://placeimg.com/100/100';
      imageUrlInput.text = 'https://placeimg.com/600/600/people';
      captionInput.text = 'Halo';
    });
  }

  final uidInput = TextEditingController();
  final usernameInput = TextEditingController();
  final avatarInput = TextEditingController();
  final imageUrlInput = TextEditingController();
  final captionInput = TextEditingController();

  final postRepository = PostRepository();
}
