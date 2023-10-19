import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/constants/constants.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';
import 'package:weather_app/src/presentation/res/keys.dart';
import 'package:weather_app/src/utils/app_utils.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    super.key,
    required AppConfiguration appConfiguration,
    Widget? title,
    List<Widget>? actions,
  }) : super(
          centerTitle: true,
          title: title,
          actions: [
            ...?actions,
            PopupMenuButton<Settings>(
              key: Key(Keys.appBarMenuButton),
              onSelected: (item) => _onSettingsSelect(appConfiguration, item),
              itemBuilder: (BuildContext context) {
                final degree = appConfiguration.isUseCelsius.value
                    ? Settings.useFahrenheit
                    : Settings.useCelsius;
                final mode =
                    Get.isDarkMode ? Settings.lightMode : Settings.darkMode;
                return <PopupMenuEntry<Settings>>[
                  PopupMenuItem<Settings>(
                    key: Key(
                        Keys.appBarMenuDarkModeOptionButton(Get.isDarkMode)),
                    value: mode,
                    child: Tooltip(
                      preferBelow: true,
                      message: mode.name,
                      child: Get.isDarkMode
                          ? const Icon(
                              Icons.light_mode_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  PopupMenuItem<Settings>(
                    key: Key(Keys.appBarMenuMetricOptionButton(
                      appConfiguration.isUseCelsius.value,
                    )),
                    value: degree,
                    child: Tooltip(
                      preferBelow: true,
                      message: degree.name,
                      child: Text(
                        AppUtils.getDegreeSymbol(
                          !appConfiguration.isUseCelsius.value,
                        ),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        );

  static void _onSettingsSelect(
    AppConfiguration appConfiguration,
    Settings setting,
  ) {
    switch (setting) {
      case Settings.lightMode:
        appConfiguration.switchThemeMode();
        break;
      case Settings.darkMode:
        appConfiguration.switchThemeMode();
        break;
      case Settings.useCelsius:
        appConfiguration.switchDegreeUnit();
        break;
      case Settings.useFahrenheit:
        appConfiguration.switchDegreeUnit();
        break;
    }
  }
}
