import 'dart:async';

import 'package:sikka_wallet/domain/repository/auth/auth_repository.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';
import 'package:sikka_wallet/domain/usecase/auth/register_user_usecase.dart';
import 'package:sikka_wallet/domain/usecase/game/get_all_games.dart';
import 'package:sikka_wallet/domain/usecase/leaderboard/get_leaderboard_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/get_post_usecase.dart';
import 'package:sikka_wallet/domain/usecase/transaction/get_transaction_history_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/get_user_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/login_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/remove_auth_token_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_auth_token_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_user_usecase.dart';
import 'package:sikka_wallet/domain/usecase/wallet/convert_currency_usecase.dart';
import 'package:sikka_wallet/domain/usecase/wallet/get_wallet_balance_usecase.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );

    getIt.registerSingleton<SaveAuthTokenUseCase>(
      SaveAuthTokenUseCase(getIt<UserRepository>()),
    );


    getIt.registerSingleton<SaveUserUseCase>(
      SaveUserUseCase(getIt<UserRepository>()),
    );

    getIt.registerSingleton<GetUserUseCase>(
      GetUserUseCase(getIt<UserRepository>()),
    );


    getIt.registerSingleton<RemoveAuthTokenUseCase>(
      RemoveAuthTokenUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );


    getIt.registerSingleton<RegisterUserUseCase>(
      RegisterUserUseCase(getIt<AuthRepository>()),
    );

    // post:--------------------------------------------------------------------
    getIt.registerSingleton<GetPostUseCase>(
      GetPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<GetLeaderBoardUseCase>(
      GetLeaderBoardUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<GetWalletBalanceUseCase>(
      GetWalletBalanceUseCase(getIt<PostRepository>()),
    );

    getIt.registerSingleton<ConvertCurrencyUseCase>(
      ConvertCurrencyUseCase(getIt<PostRepository>()),
    );

    getIt.registerSingleton<GetTransactionHistoryUseCase>(
      GetTransactionHistoryUseCase(getIt<PostRepository>()),
    );

    getIt.registerSingleton<GetAllGamesUseCase>(
      GetAllGamesUseCase(getIt<PostRepository>()),
    );

  }
}
