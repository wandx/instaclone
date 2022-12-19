import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/widgets/camera_capture/camera_capture.dart';
import 'package:instaclone/post/blocs/add_post/add_post_bloc.dart';
import 'package:instaclone/post/blocs/upload_image/upload_image_cubit.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddPostBloc()..add(Initialize())),
        BlocProvider(create: (_) => UploadImageCubit()),
      ],
      child: AddPostView(),
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
          title: const Text('Add Post'),
        ),
        body: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().uidInput,
                  decoration: const InputDecoration(
                    hintText: 'UID',
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().usernameInput,
                  decoration: const InputDecoration(
                    hintText: 'Username/Email',
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().avatarInput,
                  decoration: const InputDecoration(
                    hintText: 'Avatar',
                  ),
                ),
                BlocConsumer<UploadImageCubit, UploadImageState>(
                  listener: (context, state) {
                    print(state);
                    if (state is UploadImageSuccess) {
                      context.read<AddPostBloc>().imageUrlInput.text =
                          state.fileUrl;
                    }

                    if(state is UploadImageLoading){
                      context.read<AddPostBloc>().imageUrlInput.text = 'Loading image...';
                    }
                  },
                  builder: (context, state) {
                    return TextFormField(
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CameraCaptureScreen(),
                          ),
                        ).then((value) {
                          if (value != null && value is File) {
                            context.read<UploadImageCubit>().upload(value);
                          }
                        });
                      },
                      controller: context.read<AddPostBloc>().imageUrlInput,
                      decoration: const InputDecoration(
                        hintText: 'Image',
                      ),
                    );
                  },
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().captionInput,
                  decoration: const InputDecoration(
                    hintText: 'Caption',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddPostBloc>().add(SubmitAddPost());
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
