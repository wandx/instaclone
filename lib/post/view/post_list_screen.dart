import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/post/blocs/post_list/post_list_bloc.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostListBloc()..add(GetPosts()),
      child: PostListView(),
    );
  }
}

class PostListView extends StatelessWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          if (state is PostListLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('No Posts'),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(0),
              child: Column(
                children: state.posts
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(e.avatarUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(e.username),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Image.network(
                              e.imageUrl,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text.rich(
                                TextSpan(
                                  text: e.username,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(text: ' '),
                                    TextSpan(
                                      text: e.caption,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
