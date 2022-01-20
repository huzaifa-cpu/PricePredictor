part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserLoadedState extends UserState {
  final dynamic userModel;
  const UserLoadedState(this.userModel);
}

class UserFailureState extends UserState {
  final String msg;
  const UserFailureState(this.msg);
}
