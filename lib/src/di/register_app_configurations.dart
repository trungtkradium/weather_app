import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';
import 'package:weather_app/src/repository/configuration/configuration_share_preference_repository.dart';

Future<void> registerAppConfigurations() async {
  final configurationRepository =
      await Get.putAsync<ConfigurationSharedPreferenceService>(
    () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return ConfigurationSharedPreferenceService(prefs);
    },
    permanent: true,
  );

  Get.put<AppConfiguration>(
    AppConfiguration(configurationRepository),
    permanent: true,
  );
}
