part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserPostEvent extends UserEvent {
  const UserPostEvent({this.userModel});
  final UserModel userModel;
}

class UserGetEvent extends UserEvent {
  const UserGetEvent();
}

class UserUpdateEvent extends UserEvent {
  final UserModel userModel;
  const UserUpdateEvent(this.userModel);
}

class UserPhotoEvent extends UserEvent {
  const UserPhotoEvent();
}
