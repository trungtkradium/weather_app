abstract class AbstractConfigurationRepository {
  void setIsUseDarkMode(bool isUseDarkMode);
  bool getIsUseDarkMode();
  void setIsUseCelsius(bool isUseCelsius);
  bool getIsUseCelsius();
}

class ConfigurationRepository extends AbstractConfigurationRepository {
  final AbstractConfigurationRepository _sharedPreference;

  ConfigurationRepository(this._sharedPreference);

  @override
  bool getIsUseDarkMode() {
    return _sharedPreference.getIsUseDarkMode();
  }

  @override
  void setIsUseDarkMode(bool isUseDarkMode) {
    _sharedPreference.setIsUseDarkMode(isUseDarkMode);
  }

  @override
  bool getIsUseCelsius() {
    return _sharedPreference.getIsUseCelsius();
  }

  @override
  void setIsUseCelsius(bool isUseCelsius) {
    _sharedPreference.setIsUseCelsius(isUseCelsius);
  }
}
