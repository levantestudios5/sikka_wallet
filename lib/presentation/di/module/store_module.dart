import 'dart:async';

import 'package:sikka_wallet/core/stores/error/error_store.dart';
import 'package:sikka_wallet/core/stores/form/form_store.dart';
import 'package:sikka_wallet/domain/repository/setting/setting_repository.dart';
import 'package:sikka_wallet/domain/usecase/auth/register_user_usecase.dart';
import 'package:sikka_wallet/domain/usecase/leaderboard/get_leaderboard_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/get_post_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/login_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_auth_token_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:sikka_wallet/presentation/home/store/language/language_store.dart';
import 'package:sikka_wallet/presentation/home/store/theme/theme_store.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';

import '../../../di/service_locator.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(
      UserStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<SaveAuthTokenUseCase>(),
        getIt<LoginUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
        getIt<RegisterUserUseCase>()
      ),
    );

    getIt.registerSingleton<PostStore>(
      PostStore(
        getIt<GetPostUseCase>(),
        getIt<GetLeaderBoardUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
