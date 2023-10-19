import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/repository/configuration/configuration_repository.dart';

class ConfigurationSharedPreferenceService
    implements AbstractConfigurationRepository {
  final SharedPreferences _prefs;

  ConfigurationSharedPreferenceService(this._prefs);

  final String isUseDarkModeKey = 'isUseDarkMode';
  final String isUseCelsiusKey = 'isUseCelsius';

  @override
  bool getIsUseDarkMode() {
    final isUseDarkMode = _prefs.getBool(isUseDarkModeKey) ?? false;
    return isUseDarkMode;
  }

  @override
  void setIsUseDarkMode(bool isUseDarkMode) {
    _prefs.setBool(isUseDarkModeKey, isUseDarkMode);
  }

  @override
  bool getIsUseCelsius() {
    final isUseCelsius = _prefs.getBool(isUseCelsiusKey) ?? false;
    return isUseCelsius;
  }

  @override
  void setIsUseCelsius(bool isUseCelsius) {
    _prefs.setBool(isUseCelsiusKey, isUseCelsius);
  }
}
