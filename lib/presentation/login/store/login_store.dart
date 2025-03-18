import 'package:sikka_wallet/core/stores/error/error_store.dart';
import 'package:sikka_wallet/core/stores/form/form_store.dart';
import 'package:sikka_wallet/domain/entity/auth/register_request.dart';
import 'package:sikka_wallet/domain/usecase/auth/register_user_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

part 'login_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // constructor:---------------------------------------------------------------
  _UserStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this.formErrorStore,
    this.errorStore,
      this._registerUserUseCase,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
    });
  }

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUserUseCase _registerUserUseCase;

  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<User?> emptyLoginResponse =
      ObservableFuture.value(null);
  static ObservableFuture<String?> emptyRegisterResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  bool isLoggedIn = false;

  @observable
  bool success = false;

  @observable
  ObservableFuture<User?> loginFuture = emptyLoginResponse;
  @observable
  ObservableFuture<String?> registerFuture = emptyRegisterResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @computed
  bool get isRegisterLoading => registerFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<String> registerUser(String fullName, String email, String password, String inviteCode, String country) async {
    final RegisterRequest registerParams = RegisterRequest(
      fullName: fullName,
      email: email,
      password: password,
      inviteCode: inviteCode,
      country: country,
    );

    final future = _registerUserUseCase.call(params: registerParams);
    registerFuture = ObservableFuture(future);

    return await future.then((value) async {
      this.success = true;
      return value; // Return the success message
    }).catchError((e) {
      print(e);
      this.success = false;
      throw e;
    });
  }


  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(username: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        await _saveLoginStatusUseCase.call(params: true);
        this.isLoggedIn = true;
        this.success = true;
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  logout() async {
    this.isLoggedIn = false;
    await _saveLoginStatusUseCase.call(params: false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
