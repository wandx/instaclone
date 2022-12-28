part of 'messaging_cubit.dart';

abstract class MessagingState extends Equatable {
  const MessagingState();
}

class MessagingInitial extends MessagingState {
  @override
  List<Object> get props => [];
}

class MessagingLoading extends MessagingState {
  @override
  List<Object> get props => [];
}

class MessagingLoaded extends MessagingState {
  final RemoteMessage message;

  const MessagingLoaded(this.message);

  @override
  List<Object> get props => [message];
}
