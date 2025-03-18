// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on _PostStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_PostStore.loading'))
      .value;
  Computed<bool>? _$loadingRanksComputed;

  @override
  bool get loadingRanks =>
      (_$loadingRanksComputed ??= Computed<bool>(() => super.loadingRanks,
              name: '_PostStore.loadingRanks'))
          .value;

  late final _$fetchPostsFutureAtom =
      Atom(name: '_PostStore.fetchPostsFuture', context: context);

  @override
  ObservableFuture<SikkaXNewsList> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<SikkaXNewsList> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  late final _$fetchLeaderBoardEntryListFutureAtom = Atom(
      name: '_PostStore.fetchLeaderBoardEntryListFuture', context: context);

  @override
  ObservableFuture<LeaderBoardEntryList> get fetchLeaderBoardEntryListFuture {
    _$fetchLeaderBoardEntryListFutureAtom.reportRead();
    return super.fetchLeaderBoardEntryListFuture;
  }

  @override
  set fetchLeaderBoardEntryListFuture(
      ObservableFuture<LeaderBoardEntryList> value) {
    _$fetchLeaderBoardEntryListFutureAtom
        .reportWrite(value, super.fetchLeaderBoardEntryListFuture, () {
      super.fetchLeaderBoardEntryListFuture = value;
    });
  }

  late final _$postListAtom =
      Atom(name: '_PostStore.postList', context: context);

  @override
  SikkaXNewsList? get postList {
    _$postListAtom.reportRead();
    return super.postList;
  }

  @override
  set postList(SikkaXNewsList? value) {
    _$postListAtom.reportWrite(value, super.postList, () {
      super.postList = value;
    });
  }

  late final _$leaderBoardEntryListAtom =
      Atom(name: '_PostStore.leaderBoardEntryList', context: context);

  @override
  LeaderBoardEntryList? get leaderBoardEntryList {
    _$leaderBoardEntryListAtom.reportRead();
    return super.leaderBoardEntryList;
  }

  @override
  set leaderBoardEntryList(LeaderBoardEntryList? value) {
    _$leaderBoardEntryListAtom.reportWrite(value, super.leaderBoardEntryList,
        () {
      super.leaderBoardEntryList = value;
    });
  }

  late final _$successAtom = Atom(name: '_PostStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$getPostsAsyncAction =
      AsyncAction('_PostStore.getPosts', context: context);

  @override
  Future<dynamic> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  late final _$getLeaderBoardAsyncAction =
      AsyncAction('_PostStore.getLeaderBoard', context: context);

  @override
  Future<dynamic> getLeaderBoard() {
    return _$getLeaderBoardAsyncAction.run(() => super.getLeaderBoard());
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
fetchLeaderBoardEntryListFuture: ${fetchLeaderBoardEntryListFuture},
postList: ${postList},
leaderBoardEntryList: ${leaderBoardEntryList},
success: ${success},
loading: ${loading},
loadingRanks: ${loadingRanks}
    ''';
  }
}
