import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  MessagingCubit() : super(MessagingInitial());

  void initialize() {
    log('Initialize Firebase message');
    FirebaseMessaging.instance.getToken().then((token) {
      log('Token: $token');
    }).whenComplete(() {
      FirebaseMessaging.onMessage.listen((event) {
        print(event.data);
        emit(MessagingLoading());
        emit(MessagingLoaded(event));
      });
    });
  }
}
