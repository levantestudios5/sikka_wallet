import 'package:sikka_wallet/data/network/apis/auth/auth_api.dart';
import 'package:sikka_wallet/domain/entity/auth/register_request.dart';
import 'package:sikka_wallet/domain/repository/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  // data source object

  // api objects
  final AuthApi _authApi;

  // constructor
  AuthRepositoryImpl(this._authApi);

  @override
  Future<String> registerUser(RegisterRequest request) async {
    return await _authApi.registerUser(request).then((response) {
      return response; // The response contains the success message
    }).catchError((error) => throw error);
  }

  @override
  Future<String> resetPassword(String email) async {
    return await _authApi.resetPassword(email).then((response) {
      return response; // The response contains the success message
    }).catchError((error) => throw error);
  }
}
