import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SubmitLogin>((event, emit) async {
      emit(LoginLoading());
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final firebaseAuth = FirebaseAuth.instance;

        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).then((userCredential){
          emit(LoginSuccess());
        }).onError((error, stackTrace){
          emit(LoginFailed(error.toString()));
        });
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
}
