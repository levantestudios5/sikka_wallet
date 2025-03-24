import 'package:sikka_wallet/domain/entity/auth/authentication_response.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user/user_repository.dart';

class GetUserUseCase implements UseCase<User?, void> {
  final UserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  @override
  Future<User?> call({required void params}) async {
    return _userRepository.getUser();
  }
}
