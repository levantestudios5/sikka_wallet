import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/transaction/transaction.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class GetTransactionHistoryUseCase extends UseCase<TransactionList, void> {
  final PostRepository _repository;

  GetTransactionHistoryUseCase(this._repository);

  Future<TransactionList> call({required params}) {
    return _repository.getTransactionHistory();
  }
}
