import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('${bloc.toString()} From: ${change.currentState}');
    log('${bloc.toString()} To: ${change.nextState}');
  }
}
