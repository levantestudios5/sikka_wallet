import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/game/game.dart';
import 'package:sikka_wallet/domain/entity/game/game.dart';
import 'package:sikka_wallet/domain/entity/transaction/transaction.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class GetAllGamesUseCase extends UseCase<GameList, void> {
  final PostRepository _repository;

  GetAllGamesUseCase(this._repository);

  Future<GameList> call({required params}) {
    return _repository.getAllGames();
  }
}
