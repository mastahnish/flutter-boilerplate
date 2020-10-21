import 'package:htd_poc/main.dart';
import 'package:htd_poc/model/user.dart';
import 'package:htd_poc/services/api_service.dart';

class UsersRepository {
  final ApiService _apiService = locator.get();

  final Map<int, User> _cachedUsers = {};

  Future<User> fetchUser(int id) async {
    if (_cachedUsers.containsKey(id)) {
      return _cachedUsers[id];
    }
    final User user = await _apiService.fetchUser(id);
    _cachedUsers[id] = user;
    return user;
  }
}
