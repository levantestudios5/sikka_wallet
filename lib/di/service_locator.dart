import 'package:sikka_wallet/data/di/data_layer_injection.dart';
import 'package:sikka_wallet/domain/di/domain_layer_injection.dart';
import 'package:sikka_wallet/presentation/di/presentation_layer_injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> configureDependencies() async {
    await DataLayerInjection.configureDataLayerInjection();
    await DomainLayerInjection.configureDomainLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
