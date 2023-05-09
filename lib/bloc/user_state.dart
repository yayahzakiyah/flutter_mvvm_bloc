part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<UserModel> users;

  UserSuccess({required this.users});
}

class UserCreated extends UserState {
  final UserModel createdUser;

  UserCreated({required this.createdUser});
}

class UserUpdated extends UserState {
  final UserModel updatedUser;

  UserUpdated({required this.updatedUser});
}

class UserDeleted extends UserState {}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}