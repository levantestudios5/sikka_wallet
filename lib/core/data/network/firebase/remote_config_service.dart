import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final UserStore userStore = getIt<UserStore>();

  Future<void> initialize() async {
    print("We are coming into here");
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10), // Timeout if Firebase is slow
        minimumFetchInterval: Duration.zero, // Allow fetching new values instantly// How often to fetch updates
      ),
    );

    await _remoteConfig.setDefaults(const {
      'blacklist_version': '',
      'is_force_update': false,
      'show_wallet_ft': false,
      'shiba_inu_conversion_value': 0,
      'sikka_coin_conversion_value': 0,
      'sikkax_wallet_version': 0
    });

    await fetchRemoteConfig();
  }

  void showAllValues() {
    _remoteConfig.getAll().forEach((key, value) {
      print("Alpfa: $key: ${value.asString()}");
    });
  }
  Future<void> fetchRemoteConfig() async {
    try {
      await _remoteConfig.fetchAndActivate(); // Fetch new values
      print("Remote Config fetched successfully!");
      print("BlackListVersion ${_remoteConfig.getString('blacklist_version')}");
      showAllValues();
    } catch (e) {
      print("Remote Config fetch failed: $e");
    }
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  String? get blackListVersion => _remoteConfig.getString('blacklist_version');

  bool get isForceUpdate => _remoteConfig.getBool('is_force_update');
  bool get shouldShowWallet => _remoteConfig.getBool('show_wallet_ft');

  double? get shibaInuConversionValue =>
      _remoteConfig.getDouble('shiba_inu_conversion_value');

  double? get sikkaXConversionValue =>
      _remoteConfig.getDouble('sikka_coin_conversion_value');

  int? get sikkaWalletVersion =>
      _remoteConfig.getInt('sikkax_wallet_version');
}
