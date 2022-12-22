import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaclone/post/model/post.dart';

part 'like_post_event.dart';

part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  LikePostBloc() : super(LikePostInitial()) {
    on<LikePost>((event, emit) async {
      emit(LikePostLoading());
      final fa = FirebaseAuth.instance;
      final cu = fa.currentUser;
      final cf = FirebaseFirestore.instance;
      final doc = cf.doc('posts/${event.post.id}');

      var currentUserLike = <String>[];
      if (event.post.userLikes.isEmpty) {
        currentUserLike.addAll(event.post.userLikes);
      }

      currentUserLike.add(cu!.uid);
      final newPost = event.post.copyWith(userLikes: currentUserLike);

      await doc.update(newPost.toJson()).then((value) {
        emit(LikePostSuccess(newPost));
      }).onError((error, stackTrace) {
        emit(LikePostFailed(error.toString()));
      });
    });

    on<UnLikePost>((event, emit) async {
      emit(LikePostLoading());
      final fa = FirebaseAuth.instance;
      final cu = fa.currentUser;
      final cf = FirebaseFirestore.instance;
      final doc = cf.doc('posts/${event.post.id}');

      var currentUserLike = <String>[];
      if (event.post.userLikes.isEmpty) {
        currentUserLike.addAll(event.post.userLikes);
      }

      if (currentUserLike.contains(cu!.uid)) {
        currentUserLike.remove(cu.uid);
      }
      final newPost = event.post.copyWith(userLikes: currentUserLike);

      await doc.update(newPost.toJson()).then((value) {
        emit(LikePostSuccess(newPost));
      }).onError((error, stackTrace) {
        emit(LikePostFailed(error.toString()));
      });
    });

    on<ToggleLikePost>((event, emit) async {
      emit(LikePostLoading());
      final fa = FirebaseAuth.instance;
      final cu = fa.currentUser;
      final cf = FirebaseFirestore.instance;
      final doc = cf.doc('posts/${event.post.id}');

      var currentUserLike = <String>[...event.post.userLikes];
      if (currentUserLike.contains(cu!.uid)) {
        currentUserLike.remove(cu.uid);
      } else {
        currentUserLike.add(cu.uid);
      }

      final newPost = event.post.copyWith(userLikes: currentUserLike);

      await doc.update(newPost.toJson()).then((value) {
        emit(LikePostSuccess(newPost));
      }).onError((error, stackTrace) {
        emit(LikePostFailed(error.toString()));
      });
    });
  }
}
