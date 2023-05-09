part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class FetchUser extends UserEvent {
  final int id;

  FetchUser({required this.id});
}

class CreateUser extends UserEvent {
  final Map<String, dynamic> user;

  CreateUser({required this.user});
}

class UpdateUser extends UserEvent {
  final int id;
  final Map<String, dynamic> user;

  UpdateUser({required this.id, required this.user});
}

class DeleteUser extends UserEvent {
  final int id;

  DeleteUser({required this.id});
}
