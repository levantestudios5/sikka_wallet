import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';

class RemoveAuthTokenUseCase implements UseCase<bool, void> {
  final UserRepository _userRepository;

  RemoveAuthTokenUseCase(this._userRepository);

  @override
  Future<bool> call({required void params}) async {
    return await _userRepository.removeAuthToken();
  }
}
