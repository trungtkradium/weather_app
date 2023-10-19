import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/repository/configuration/configuration_repository.dart';

class AppConfiguration {
  static AppConfiguration get to => Get.find<AppConfiguration>();

  final AbstractConfigurationRepository _repository;

  AppConfiguration(this._repository) {
    final useCelsius = _repository.getIsUseCelsius();
    isUseCelsius.value = useCelsius;
  }

  final isUseCelsius = true.obs;

  bool get getIsUseDarkMode => _repository.getIsUseDarkMode();

  bool get getIsUseCelsius => _repository.getIsUseCelsius();

  void switchDegreeUnit() {
    _repository.setIsUseCelsius(!isUseCelsius.value);
    isUseCelsius.value = !isUseCelsius.value;
  }

  void switchThemeMode() {
    _repository.setIsUseDarkMode(!Get.isDarkMode);
    Get.changeTheme(
      Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
    );
  }
}
