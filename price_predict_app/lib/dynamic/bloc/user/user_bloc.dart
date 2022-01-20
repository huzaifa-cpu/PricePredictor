import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_predict_app/dynamic/API/user_repo.dart';
import 'package:price_predict_app/dynamic/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  UserRepository _userRepository = UserRepository();
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserGetEvent) {
      try {
        yield UserLoadingState();
        dynamic userModel = await _userRepository.getUser();
        yield UserLoadedState(userModel);
      } on Exception {
        yield UserFailureState('Network Error');
      }
    }
    if (event is UserPostEvent) {
      try {
        yield UserLoadingState();
        UserModel userModel = await _userRepository.insertUser(event.userModel);
        yield UserLoadedState(userModel);
      } on Exception {
        yield UserFailureState('Network Error');
      }
    }
    if (event is UserUpdateEvent) {
      try {
        yield UserLoadingState();
        await _userRepository.updateUser(event.userModel);
        UserModel userModel = await _userRepository.getUser();
        yield UserLoadedState(userModel);
      } on Exception {
        yield UserFailureState('Network Error');
      }
    }
    if (event is UserPhotoEvent) {
      try {
        yield UserLoadingState();
      } on Exception {
        yield UserFailureState('Network Error');
      }
    }
  }
}
