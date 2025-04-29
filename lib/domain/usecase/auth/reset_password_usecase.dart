import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/auth/register_request.dart';
import 'package:sikka_wallet/domain/repository/auth/auth_repository.dart';

class ResetPasswordUseCase extends UseCase<String, String> {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  @override
  Future<String> call({required String params}) {
    return _authRepository.resetPassword(params);
  }
}
