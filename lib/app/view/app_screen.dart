import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/blocs/auth/auth_bloc.dart';
import 'package:instaclone/app/view/splash_screen.dart';
import 'package:instaclone/login/login.dart';
import 'package:instaclone/post/view/add_post_screen.dart';
import 'package:instaclone/post/view/post_list_screen.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instaclone',
      home: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state);
          if (state is AuthError) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                // builder: (_) => const HomeScreen(),
                builder: (_) => const PostListScreen(),
              ),
            );
          }
        },
        child: const SplashScreen(),
      ),
    );
  }
}
