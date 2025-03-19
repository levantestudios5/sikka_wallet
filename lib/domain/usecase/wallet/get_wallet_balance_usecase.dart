import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class GetWalletBalanceUseCase extends UseCase<WalletData, void>{
  final PostRepository _repository;

  GetWalletBalanceUseCase(this._repository);

  Future<WalletData> call({required params}) {
    return  _repository.getWalletBalance();
  }
}
