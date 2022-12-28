import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/blocs/messaging/messaging_cubit.dart';
import 'package:instaclone/post/blocs/like_post/like_post_bloc.dart';
import 'package:instaclone/post/blocs/post_list/post_list_bloc.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostListBloc()..add(GetPosts())),
        BlocProvider(create: (context) => LikePostBloc()),
      ],
      child: PostListView(),
    );
  }
}

class PostListView extends StatelessWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LikePostBloc, LikePostState>(
          listener: (context, state) {
            if (state is LikePostSuccess) {
              context.read<PostListBloc>().add(UpdatePost(state.post));
            }
          },
        ),
        BlocListener<MessagingCubit, MessagingState>(
          listener: (context, state) {
            if (state is MessagingLoaded) {
              final message = state.message;
              if (message.data.containsKey('type') &&
                  message.data['type'] == 'like') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Your post liked by ${message.data['user']}'),
                  ),
                );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: BlocBuilder<PostListBloc, PostListState>(
          builder: (context, state) {
            if (state is PostListLoading || state is PostListInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (context.read<PostListBloc>().allPost.isEmpty) {
              return Center(
                child: Text('No Posts'),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(0),
              child: Column(
                children: context
                    .read<PostListBloc>()
                    .allPost
                    .map(
                      (e) => GestureDetector(
                        onDoubleTap: () {
                          context.read<LikePostBloc>().add(LikePost(e));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              Row(
                                children: [
                                  BlocBuilder<LikePostBloc, LikePostState>(
                                    builder: (context, state) {
                                      if (state is LikePostSuccess) {
                                        return IconButton(
                                          onPressed: () {
                                            print('Fresh Object');
                                            context.read<LikePostBloc>().add(
                                                ToggleLikePost(state.post));
                                          },
                                          icon: Builder(builder: (context) {
                                            if (state.post.isLikedByUser) {
                                              return Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              );
                                            }
                                            return Icon(Icons.favorite_border);
                                          }),
                                        );
                                      }
                                      return IconButton(
                                        onPressed: () {
                                          print('Old Object');
                                          context
                                              .read<LikePostBloc>()
                                              .add(ToggleLikePost(e));
                                        },
                                        icon: Builder(builder: (context) {
                                          if (e.isLikedByUser) {
                                            return Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            );
                                          }
                                          return Icon(Icons.favorite_border);
                                        }),
                                      );
                                    },
                                  ),
                                ],
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
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
