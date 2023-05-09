import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/bloc/user_bloc.dart';
import 'package:mvvm_bloc/data/api/service/user_service.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(userService: UserService());
    _userBloc.add(FetchUsers());
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserSuccess) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.first_name + ' ' + user.last_name),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _userBloc.add(DeleteUser(id: user.id));
                    },
                  ),
                );
              },
            );
          }

          if (state is UserError) {
            return Center(
              child: Text(state.error),
            );
          }

          return Center(
            child: Text('Unknown error'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add_user') as Map<String, dynamic>;
          if (result != null) {
            _userBloc.add(CreateUser(user: result));
          }
        },
      ),
    );
  }
}
