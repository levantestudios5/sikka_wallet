import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/auth/authentication_response.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';

class SaveUserUseCase implements UseCase<void, User> {
final UserRepository _userRepository;

SaveUserUseCase(this._userRepository);

@override
Future<void> call({required User params}) async {
return _userRepository.saveUser(params);
}
}


