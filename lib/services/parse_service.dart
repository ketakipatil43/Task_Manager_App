import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseService {
  // ---------------- USER AUTH ----------------

  Future<ParseUser?> register(String email, String password) async {
    final user = ParseUser(email, password, email);
    final response = await user.signUp();

    if (response.success) {
      return response.result as ParseUser;
    }
    throw Exception(response.error?.message);
  }

  Future<ParseUser?> login(String email, String password) async {
    final user = ParseUser(email, password, email);
    final response = await user.login();

    if (response.success) {
      return response.result as ParseUser;
    }
    throw Exception(response.error?.message);
  }

  Future<void> logout() async {
    final user = await ParseUser.currentUser();
    if (user != null) {
      await user.logout();
    }
  }

  // ---------------- TASK CRUD ----------------

  static Future<ParseObject> createTask(String title, String description) async {
    final user = await ParseUser.currentUser();

    final task = ParseObject('Task')
      ..set('title', title)
      ..set('description', description)
      ..set('completed', false)
      ..set('user', user);

    final response = await task.save();
    if (response.success) {
      return response.result;
    }
    throw Exception(response.error?.message);
  }

  Future<List<ParseObject>> getTasks() async {
    final user = await ParseUser.currentUser();

    final query = QueryBuilder<ParseObject>(ParseObject('Task'))
      ..whereEqualTo('user', user)
      ..orderByDescending('createdAt');

    final response = await query.query();

    if (response.success) {
      return response.results?.cast<ParseObject>() ?? [];
    }
    throw Exception(response.error?.message);
  }

  static Future<void> updateTask(
      ParseObject task, String title, String description) async {
    task
      ..set('title', title)
      ..set('description', description);

    final response = await task.save();
    if (!response.success) {
      throw Exception(response.error?.message);
    }
  }

  Future<void> deleteTask(ParseObject task) async {
    final response = await task.delete();
    if (!response.success) {
      throw Exception(response.error?.message);
    }
  }
}
