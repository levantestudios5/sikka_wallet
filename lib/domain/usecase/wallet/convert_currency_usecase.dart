import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/wallet/conversion.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet_conversion_request.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class ConvertCurrencyUseCase
    extends UseCase<WalletConversion, WalletConversionRequest> {
  final PostRepository _repository;

  ConvertCurrencyUseCase(this._repository);

  Future<WalletConversion> call({required params}) {
    return _repository.convertCurrency(params);
  }
}


