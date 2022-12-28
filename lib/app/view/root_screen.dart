import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/blocs/auth/auth_bloc.dart';
import 'package:instaclone/app/blocs/messaging/messaging_cubit.dart';
import 'package:instaclone/app/view/app_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckAuth())),
        BlocProvider(create: (context) => MessagingCubit()),
      ],
      child: const AppScreen(),
    );
  }
}
