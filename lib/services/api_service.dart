import 'dart:convert';

import 'package:htd_poc/model/post.dart';
import 'package:htd_poc/model/user.dart';
import 'package:http/http.dart';

class ApiService {
  static const _apiUrl = "http://jsonplaceholder.typicode.com";

  Future<Post> fetchSinglePost(int id) async {
    return get("$_apiUrl/posts/$id").then((Response response) {
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        final Map jsonResponse = jsonDecode(response.body);
        return jsonResponse.isNotEmpty ? Post.fromJson(jsonResponse) : null;
      } else if (statusCode == 404) {
        return null;
      } else {
        throw "request error: $statusCode";
      }
    });
  }

  Future<User> fetchUser(int id) async {
    return get("$_apiUrl/users/$id").then((Response response) {
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        final Map jsonResponse = jsonDecode(response.body);
        return jsonResponse.isNotEmpty ? User.fromJson(jsonResponse) : null;
      } else {
        throw "request error: $statusCode";
      }
    });
  }
}
