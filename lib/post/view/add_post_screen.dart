import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/post/blocs/add_post/add_post_bloc.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPostBloc()..add(Initialize()),
      child: const AddPostView(),
    );
  }
}

class AddPostView extends StatelessWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) {
        print(state);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
        ),
        body: Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().uidInput,
                  decoration: InputDecoration(
                    hintText: 'UID',
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().usernameInput,
                  decoration: InputDecoration(
                    hintText: 'Username/Email',
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().avatarInput,
                  decoration: InputDecoration(
                    hintText: 'Avatar',
                  ),
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().imageUrlInput,
                  decoration: InputDecoration(
                    hintText: 'Image',
                  ),
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().captionInput,
                  decoration: InputDecoration(
                    hintText: 'Caption',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddPostBloc>().add(SubmitAddPost());
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
