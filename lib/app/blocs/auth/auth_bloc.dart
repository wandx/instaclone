import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaclone/app/model/user.dart' as myUser;

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuth>((event, emit) {
      emit(AuthLoading());

      final firebaseAuth = FirebaseAuth.instance;

      if (firebaseAuth.currentUser == null) {
        emit(const AuthError('User not found'));
      } else {
        final u = myUser.User(
          uid: firebaseAuth.currentUser!.uid,
          email: firebaseAuth.currentUser!.email!,
        );
        emit(AuthSuccess(u));
      }
    });

    on<Logout>((event, emit) async {
      emit(AuthLoading());
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut().then((value) {
        emit(AuthLoggedOut());
      });
    });
  }
}
