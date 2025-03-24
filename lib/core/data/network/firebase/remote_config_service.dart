import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        // Timeout for fetching config
        minimumFetchInterval:
            const Duration(hours: 1), // How often to fetch updates
      ),
    );

    await _remoteConfig.setDefaults(const {
      'blacklist_version': '0',
      'is_force_update': false,
      'shiba_inu_conversion_value': '0',
      'sikka_coin_conversion_value': '0',
      'sikkax_wallet_version': '0',
    });

    await fetchAndActivate();
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  String get blackListVersion => _remoteConfig.getString('blacklist_version');

  bool get isForceUpdate => _remoteConfig.getBool('is_force_update');

  String get shibaInuConversionValue =>
      _remoteConfig.getString('shiba_inu_conversion_value');

  String get sikkaXConversionValue =>
      _remoteConfig.getString('sikka_coin_conversion_value');

  String get sikkaWalletVersion =>
      _remoteConfig.getString('sikkax_wallet_version');
}
