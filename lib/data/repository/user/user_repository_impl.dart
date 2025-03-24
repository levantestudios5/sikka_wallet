import 'dart:async';

import 'package:sikka_wallet/data/network/apis/auth/auth_api.dart';
import 'package:sikka_wallet/domain/entity/auth/authentication_response.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';
import 'package:sikka_wallet/data/sharedpref/shared_preference_helper.dart';
import '../../../domain/usecase/user/login_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final AuthApi _authApi;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper, this._authApi);

  // Login:---------------------------------------------------------------------
  @override
  Future<LoginResponse?> login(LoginParams params) async {
    return await _authApi
        .authenticateUser(params.email, params.password)
        .then((response) {
      return response; // The response contains the success message
    }).catchError((error) => throw error);
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  @override
  Future<void> saveToken(String value) =>
      _sharedPrefsHelper.saveAuthToken(value);

  @override
  Future<bool> removeAuthToken() async =>
      await _sharedPrefsHelper.removeAuthToken();

  @override
  Future<User?> getUser() async => await _sharedPrefsHelper.getUser();

  @override
  Future<void> saveUser(User user) => _sharedPrefsHelper.saveUser(user);
}
