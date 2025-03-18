import 'dart:async';

import 'package:sikka_wallet/domain/repository/auth/auth_repository.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';
import 'package:sikka_wallet/domain/repository/user/user_repository.dart';
import 'package:sikka_wallet/domain/usecase/auth/register_user_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/delete_post_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/find_post_by_id_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/get_post_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/insert_post_usecase.dart';
import 'package:sikka_wallet/domain/usecase/post/udpate_post_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/login_usecase.dart';
import 'package:sikka_wallet/domain/usecase/user/save_login_in_status_usecase.dart';

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
    getIt.registerSingleton<FindPostByIdUseCase>(
      FindPostByIdUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<InsertPostUseCase>(
      InsertPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<UpdatePostUseCase>(
      UpdatePostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<DeletePostUseCase>(
      DeletePostUseCase(getIt<PostRepository>()),
    );
  }
}
