import 'package:mvvm_bloc/data/api/api_helper.dart';
import 'package:mvvm_bloc/data/api/endpoint.dart';
import 'package:mvvm_bloc/model/user_model.dart';

class UserService {
  Future<dynamic> getUsers() async {
    try {
      final response = await ApiHelper.get(Endpoints.user);
      print(response);
      final data = response.data['data'] as List<dynamic>;
      final users = data.map((e) => UserModel.fromJson(e)).toList();
      return users;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> createUser(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(Endpoints.user, data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateUser(int id, Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.put(Endpoints.user + '/$id', data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteUser(int id) async {
    try {
      final response = await ApiHelper.delete(Endpoints.user + '/$id');
      return response;
    } catch (e) {
      print(e);
    }
  }
}
