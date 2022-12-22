import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String uid;
  final String username;
  final String text;

  Comment({
    required this.uid,
    required this.username,
    required this.text,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      uid: json['uid'].toString(),
      username: json['username'].toString(),
      text: json['text'].toString(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid, username, text];
}
