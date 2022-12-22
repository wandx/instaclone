import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'comment.dart';

class Post extends Equatable {
  final String? id;
  final String uid;
  final String avatarUrl;
  final String username;
  final String imageUrl;
  final String caption;
  final List<String> userLikes;
  final List<Comment> userComments;

  factory Post.fromJson(Map<String, dynamic> json) {
    final likes = <String>[];
    final comments = <Comment>[];

    if (json.containsKey('userLikes')) {
      final ul = json['userLikes'] as List;
      likes.addAll(ul.map((e) => e as String).toList());
    }

    if (json.containsKey('userComments')) {
      final c = json['userComments'] as List;
      comments.addAll(c.map((e) => Comment.fromJson(e)));
    }

    return Post(
      uid: json['uid'] as String,
      avatarUrl: json['avatarUrl'] as String,
      username: json['username'].toString(),
      imageUrl: json['imageUrl'].toString(),
      caption: json['caption'].toString(),
      userLikes: likes,
      userComments: comments,
    );
  }

  bool get isLikedByUser {
    final fa = FirebaseAuth.instance;
    final cu = fa.currentUser;
    if (cu == null) {
      return false;
    }

    final uid = cu.uid;
    return userLikes.contains(uid);
  }

  Post copyWith({
    String? id,
    String? uid,
    String? avatarUrl,
    String? username,
    String? imageUrl,
    String? caption,
    List<String>? userLikes,
    List<Comment>? userComments,
  }) {
    return Post(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      userLikes: userLikes ?? this.userLikes,
      userComments: userComments ?? this.userComments,
    );
  }

  Post({
    this.id,
    required this.uid,
    required this.avatarUrl,
    required this.username,
    required this.imageUrl,
    required this.caption,
    this.userLikes = const <String>[],
    this.userComments = const <Comment>[],
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'avatarUrl': avatarUrl,
      'username': username,
      'imageUrl': imageUrl,
      'caption': caption,
      'uid': uid,
      'userLikes': userLikes,
      'userComments': userComments,
      'id':id,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        avatarUrl,
        username,
        imageUrl,
        caption,
        userLikes,
        userComments,
      ];

  @override
  String toString() {
    return 'id: $id';
  }
}
