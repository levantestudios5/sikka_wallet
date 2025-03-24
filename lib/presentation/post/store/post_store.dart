import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sikka_wallet/core/stores/error/error_store.dart';
import 'package:sikka_wallet/domain/entity/game/game.dart';
import 'package:sikka_wallet/domain/entity/leaderboard/leaderboard.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/transaction/transaction.dart';
import 'package:sikka_wallet/domain/entity/wallet/conversion.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet.dart';
import 'package:sikka_wallet/domain/entity/wallet/wallet_conversion_request.dart';
import 'package:sikka_wallet/domain/usecase/game/get_all_games.dart';
import 'package:sikka_wallet/domain/usecase/transaction/get_transaction_history_usecase.dart';
import 'package:sikka_wallet/domain/usecase/wallet/convert_currency_usecase.dart';
import 'package:sikka_wallet/domain/usecase/wallet/get_wallet_balance_usecase.dart';
import 'package:sikka_wallet/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/usecase/leaderboard/get_leaderboard_usecase.dart';
import '../../../domain/usecase/post/get_post_usecase.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // constructor:---------------------------------------------------------------
  _PostStore(
      this._getPostUseCase,
      this._getLeaderBoardUseCase,
      this._getWalletBalanceUseCase,
      this._convertCurrencyUseCase,
      this._getTransactionHistoryUseCase,
      this._getAllGamesUseCase,
      this.errorStore) {
    _initializeNotifications();
  }

  // use cases:-----------------------------------------------------------------
  final GetPostUseCase _getPostUseCase;
  final GetLeaderBoardUseCase _getLeaderBoardUseCase;
  final GetWalletBalanceUseCase _getWalletBalanceUseCase;
  final ConvertCurrencyUseCase _convertCurrencyUseCase;
  final GetTransactionHistoryUseCase _getTransactionHistoryUseCase;
  final GetAllGamesUseCase _getAllGamesUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

//todo conversion ka sara kam kr lia ha bs call kr k validate kro or
  //usk bd notification didkha do
  // store variables:-----------------------------------------------------------

  static ObservableFuture<GameList> emptyGameListResponse =
      ObservableFuture.value(GameList());

  @observable
  ObservableFuture<GameList> fetchGameListFuture =
      ObservableFuture<GameList>(emptyGameListResponse);

  static ObservableFuture<TransactionList> emptyTransactionResponse =
      ObservableFuture.value(TransactionList());

  @observable
  ObservableFuture<TransactionList> fetchTransactionFuture =
      ObservableFuture<TransactionList>(emptyTransactionResponse);

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static ObservableFuture<SikkaXNewsList> emptyPostResponse =
      ObservableFuture.value(SikkaXNewsList());

  @observable
  ObservableFuture<SikkaXNewsList> fetchPostsFuture =
      ObservableFuture<SikkaXNewsList>(emptyPostResponse);

  static ObservableFuture<WalletData> emptyWalletResponse =
      ObservableFuture.value(WalletData());

  @observable
  ObservableFuture<WalletData> fetchWalletFuture =
      ObservableFuture<WalletData>(emptyWalletResponse);

  static ObservableFuture<WalletConversion> emptyConversionResponse =
      ObservableFuture.value(WalletConversion());

  @observable
  ObservableFuture<WalletConversion> fetchConversionFuture =
      ObservableFuture<WalletConversion>(emptyConversionResponse);

  static ObservableFuture<LeaderBoardEntryList>
      emptyLeaderBoardEntryListResponse =
      ObservableFuture.value(LeaderBoardEntryList());

  @observable
  ObservableFuture<LeaderBoardEntryList> fetchLeaderBoardEntryListFuture =
      ObservableFuture<LeaderBoardEntryList>(emptyLeaderBoardEntryListResponse);

  @observable
  SikkaXNewsList? postList;

  @observable
  TransactionList? transactionList;

  @observable
  GameList? gameList;

  @observable
  WalletData? walletData;

  @observable
  int selectedIndex = 0;

  @observable
  WalletConversion? walletConversion;

  @observable
  List<Map<String, String>> coinsList = [];

  @observable
  LeaderBoardEntryList? leaderBoardEntryList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingWallet => fetchWalletFuture.status == FutureStatus.pending;

  @computed
  bool get loadingConversion =>
      fetchConversionFuture.status == FutureStatus.pending;

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
      this.leaderBoardEntryList = postList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  updateIndex(int index) {
    this.selectedIndex = index;
  }

  @action
  Future getWalletData() async {
    final future = _getWalletBalanceUseCase.call(params: null);
    fetchWalletFuture = ObservableFuture(future);
    future.then((walletData) {
      this.walletData = walletData;
      this.coinsList = walletData.getCoinList();
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future getTransactionHistory() async {
    transactionList = TransactionList();
    final future = _getTransactionHistoryUseCase.call(params: null);
    fetchTransactionFuture = ObservableFuture(future);
    future.then((transactionList) {
      this.transactionList = transactionList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future getAllGames() async {
    gameList = GameList();
    final future = _getAllGamesUseCase.call(params: null);
    fetchGameListFuture = ObservableFuture(future);
    future.then((gameList) {
      this.gameList = gameList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future convertCurrency(WalletConversionRequest request) async {
    final future = _convertCurrencyUseCase.call(params: request);
    fetchConversionFuture = ObservableFuture(future);

    return future.then((walletData) {
      getWalletData();
      getTransactionHistory();
      this.walletConversion = walletData;
      // Show notification on success
      _showSuccessNotification("${walletData.description}");
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('sikka'); // Ensure you have an app icon

    final InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);
  }

  Future<void> _showSuccessNotification(String message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
            'wallet_conversion_channel', // Channel ID
            'Wallet Conversion', // Channel name
            importance: Importance.high,
            priority: Priority.high,
            icon: 'sikka');

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // Notification ID
      'Conversion Successful', // Title
      message, // Body
      platformDetails,
    );
  }
}
