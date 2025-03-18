import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class GetLeaderBoardUseCase extends UseCase<LeaderBoardEntryList, void>{
  final PostRepository _repository;

  GetLeaderBoardUseCase(this._repository);

  Future<LeaderBoardEntryList> call({required params}) {
    return  _repository.getLeaderBoard();
  }
}
