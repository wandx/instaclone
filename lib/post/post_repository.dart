import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/app/constant/constant.dart' as constants;
import 'package:instaclone/post/model/post.dart';

class PostRepository {
  final cf = FirebaseFirestore.instance;

  Future<Post> create(Post post) async {
    return await cf
        .collection(constants.postCollectionName)
        .add(post.toJson())
        .then((doc) {
      return Post(
        id: doc.id,
        username: post.username,
        avatarUrl: post.avatarUrl,
        caption: post.caption,
        imageUrl: post.imageUrl,
        uid: post.uid,
      );
    });
  }

  Future<List<Post>> all() async {
    return await cf.collection(constants.postCollectionName).get().then(
      (snapshot) {
        return snapshot.docs.map<Post>((e) {
          return Post(
            id: e.id,
            username: e.data()['username'].toString(),
            uid: e.data()['uid'].toString(),
            imageUrl: e.data()['imageUrl'].toString(),
            caption: e.data()['caption'].toString(),
            avatarUrl: e.data()['avatarUrl'].toString(),
          );
        }).toList();
      },
    );
  }

  void update() {}

  void delete() {}
}
