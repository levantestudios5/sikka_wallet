import 'package:sikka_wallet/domain/entity/auth/register_request.dart';

abstract class AuthRepository {
  Future<String> registerUser(RegisterRequest request);
}
