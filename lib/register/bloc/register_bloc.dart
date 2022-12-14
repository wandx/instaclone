import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<SubmitRegister>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(RegisterLoading());
        final fa = FirebaseAuth.instance;
        await fa
            .createUserWithEmailAndPassword(
          email: emailInput.text,
          password: passwordInput.text,
        )
            .then((userCredential) {
          emit(RegisterSuccess());
        }).catchError((error) {
          emit(RegisterFailed(error.toString()));
        });
      }
    });
  }

  String? validateEmail(String? v) {
    if (v == null || v.isEmpty) {
      return 'Email required.';
    }
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) {
      return 'Password required.';
    }

    if (v.length < 8) {
      return 'Password min 8 char';
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
}
