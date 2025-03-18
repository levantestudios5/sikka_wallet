import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/auth/register_request.dart';
import 'package:sikka_wallet/domain/repository/auth/auth_repository.dart';

class RegisterUserUseCase extends UseCase<String, RegisterRequest> {
  final AuthRepository _authRepository;

  RegisterUserUseCase(this._authRepository);

  @override
  Future<String> call({required RegisterRequest params}) {
    return _authRepository.registerUser(params);
  }
}
