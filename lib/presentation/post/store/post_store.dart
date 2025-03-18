import 'package:sikka_wallet/core/stores/error/error_store.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/post/post_list.dart';
import 'package:sikka_wallet/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/usecase/leaderboard/get_leaderboard_usecase.dart';
import '../../../domain/usecase/post/get_post_usecase.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // constructor:---------------------------------------------------------------
  _PostStore(
      this._getPostUseCase, this._getLeaderBoardUseCase, this.errorStore);

  // use cases:-----------------------------------------------------------------
  final GetPostUseCase _getPostUseCase;
  final GetLeaderBoardUseCase _getLeaderBoardUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<SikkaXNewsList> emptyPostResponse =
      ObservableFuture.value(SikkaXNewsList());

  @observable
  ObservableFuture<SikkaXNewsList> fetchPostsFuture =
      ObservableFuture<SikkaXNewsList>(emptyPostResponse);

  static ObservableFuture<LeaderBoardEntryList>
      emptyLeaderBoardEntryListResponse =
      ObservableFuture.value(LeaderBoardEntryList());

  @observable
  ObservableFuture<LeaderBoardEntryList> fetchLeaderBoardEntryListFuture =
      ObservableFuture<LeaderBoardEntryList>(emptyLeaderBoardEntryListResponse);

  @observable
  SikkaXNewsList? postList;
  @observable
  LeaderBoardEntryList? leaderBoardEntryList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingRanks =>
      fetchLeaderBoardEntryListFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPosts() async {

      final future = _getPostUseCase.call(params: null);
      fetchPostsFuture = ObservableFuture(future);
      future.then((postList) {
        this.postList = postList;
      }).catchError((error) {
        errorStore.errorMessage = DioExceptionUtil.handleError(error);
      });

  }

  @action
  Future getLeaderBoard() async {

      final future = _getLeaderBoardUseCase.call(params: null);
      fetchLeaderBoardEntryListFuture = ObservableFuture(future);
      future.then((postList) {
        postList.posts!.sort((a, b) => a.rank.compareTo(b.rank));
        this.leaderBoardEntryList=postList;
      }).catchError((error) {
        errorStore.errorMessage = DioExceptionUtil.handleError(error);
      });

  }
}
