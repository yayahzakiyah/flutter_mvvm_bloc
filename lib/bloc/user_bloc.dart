import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/data/api/service/user_service.dart';
import 'package:mvvm_bloc/model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;

  UserBloc({required UserService userService})
      : _userService = userService,
        super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await _userService.getUsers();
        print(users);
        emit(UserSuccess(users: users));
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });

    on<CreateUser>((event, emit) async {
      try {
        final createdUser = await _userService.createUser(event.user);
        print(createdUser);
        emit(UserCreated(createdUser: createdUser));
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      try {
        final updatedUser = await _userService.updateUser(event.id, event.user);
        emit(UserUpdated(updatedUser: updatedUser));
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      try {
        await _userService.deleteUser(event.id);
        emit(UserDeleted());
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });
  }
}
