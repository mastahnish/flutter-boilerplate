import 'dart:convert';

import 'package:htd_poc/model/user.dart';
import 'package:http/http.dart';

class UsersRepository {
  static const _apiUrl = "http://jsonplaceholder.typicode.com";

  final Map<int, User> _cachedUsers = {};

  Future<User> fetchUser(int id) async {
    if (_cachedUsers.containsKey(id)) {
      return _cachedUsers[id];
    }
    final User user = await _fetchUser(id);
    _cachedUsers[id] = user;
    return user;
  }

  Future<User> _fetchUser(int id) async {
    return get("$_apiUrl/users/$id").then((Response response) {
      if (response.statusCode == 200) {
        final Map jsonResponse = jsonDecode(response.body);
        return jsonResponse.isNotEmpty ? User.fromJson(jsonResponse) : null;
      } else {
        throw "request error";
      }
    });
  }
}
