import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    print("We are coming into here");
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10), // Timeout if Firebase is slow
        minimumFetchInterval: Duration.zero, // Allow fetching new values instantly// How often to fetch updates
      ),
    );

    await _remoteConfig.setDefaults(const {
      'blacklist_version': 100,
      'is_force_update': false,
      'shiba_inu_conversion_value': 100,
      'sikka_coin_conversion_value': 100,
      'sikkax_wallet_version': 100
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
      print("BlackListVersion ${_remoteConfig.getInt('blacklist_version')}");
      showAllValues();
    } catch (e) {
      print("Remote Config fetch failed: $e");
    }
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  int? get blackListVersion => _remoteConfig.getInt('blacklist_version');

  bool get isForceUpdate => _remoteConfig.getBool('is_force_update');

  int? get shibaInuConversionValue =>
      _remoteConfig.getInt('shiba_inu_conversion_value');

  int? get sikkaXConversionValue =>
      _remoteConfig.getInt('sikka_coin_conversion_value');

  int? get sikkaWalletVersion =>
      _remoteConfig.getInt('sikkax_wallet_version');
}
