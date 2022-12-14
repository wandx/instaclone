class Post {
  final String? id;
  final String uid;
  final String avatarUrl;
  final String username;
  final String imageUrl;
  final String caption;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uid: json['uid'] as String,
      avatarUrl: json['avatarUrl'] as String,
      username: json['username'].toString(),
      imageUrl: json['imageUrl'].toString(),
      caption: json['caption'].toString(),
    );
  }

  Post({
    this.id,
    required this.uid,
    required this.avatarUrl,
    required this.username,
    required this.imageUrl,
    required this.caption,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'avatarUrl': avatarUrl,
      'username': username,
      'imageUrl': imageUrl,
      'caption': caption,
      'uid': uid,
    };
  }
}
