part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserProfileLoading extends UserState {}

class UserProfileLoaded extends UserState {
  final User user;
  UserProfileLoaded(this.user);
}

class UserProfileError extends UserState {
  final String message;
  UserProfileError(this.message);
}
