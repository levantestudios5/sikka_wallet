import 'dart:async';
import 'package:sikka_wallet/data/network/apis/auth/auth_api.dart';
import 'package:sikka_wallet/data/network/apis/posts/post_api.dart';
import 'package:sikka_wallet/data/repository/auth/auth_repository_impl.dart';
import 'package:sikka_wallet/data/repository/post/post_repository_impl.dart';
import 'package:sikka_wallet/data/repository/setting/setting_repository_impl.dart';
import 'package:sikka_wallet/data/repository/user/user_repository_impl.dart';
import 'package:sikka_wallet/data/sharedpref/shared_preference_helper.dart';
import 'package:sikka_wallet/domain/repository/auth/auth_repository.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';
import 'package:sikka_wallet/domain/repository/setting/setting_repository.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
    ));

    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      getIt<AuthApi>(),
    ));
  }
}
