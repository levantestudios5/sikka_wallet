import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';

class SaveAuthTokenUseCase implements UseCase<void, String> {
  final UserRepository _userRepository;

  SaveAuthTokenUseCase(this._userRepository);

  @override
  Future<void> call({required String params}) async {
    return _userRepository.saveToken(params);
  }
}