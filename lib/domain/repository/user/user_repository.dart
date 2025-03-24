import 'dart:async';

import 'package:sikka_wallet/domain/entity/auth/authentication_response.dart';
import 'package:sikka_wallet/domain/usecase/user/login_usecase.dart';

abstract class UserRepository {
  Future<LoginResponse?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<void> saveToken(String value);

  Future<bool> get isLoggedIn;
  Future<bool> removeAuthToken();
  Future<void> saveUser(User user);
  Future<User?> getUser();

}
