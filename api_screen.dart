import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  static const String baseUrl = "https://67cec035125cd5af757bd5cc.mockapi.io/users";

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((json) => UserModel.fromMap(json)).toList();
    } else {
      throw Exception("Failed to fetch users: ${response.statusCode}");
    }
  }

  Future<UserModel> addUser(UserModel user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toMap()..remove('id')),
    );
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      user.id = int.parse(json['id']);
      return user;
    } else {
      throw Exception("Failed to add user: ${response.statusCode}");
    }
  }

  Future<void> updateUser(String id, UserModel user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update user: ${response.statusCode}");
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete user: ${response.statusCode}");
    }
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"isFavorite": !isFavorite}),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to toggle favorite: ${response.statusCode}");
    }
  }
}