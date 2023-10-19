import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/business/weather_state.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';
import 'package:weather_app/src/presentation/components/base_app_bar.dart';
import 'package:weather_app/src/presentation/components/weather_information.dart';
import 'package:weather_app/src/presentation/res/keys.dart';
import 'package:weather_app/src/presentation/screens/weather_history_screen.dart';
import 'package:weather_app/src/repository/weather/weather_repository.dart';
import 'package:weather_app/src/utils/request_exception_handler.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  static const String routeName = '/weather_screen';

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _searchKeywordController = TextEditingController();
  final _searchKeywordFocusNode = FocusNode();

  InputDecoration get _inputDecoration => InputDecoration(
        labelText: "Fill in country's name or zip code",
        suffixIcon: GestureDetector(
          key: Key(Keys.searchHistoryNavigateButton),
          onTap: () => Get.toNamed(WeatherHistoryScreen.routeName),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.history),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final appConfiguration = AppConfiguration.to;
    final weatherState = WeatherState.to;
    return Scaffold(
      appBar: BaseAppBar(
        appConfiguration: appConfiguration,
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: Key(Keys.searchTextField),
              controller: _searchKeywordController,
              focusNode: _searchKeywordFocusNode,
              decoration: _inputDecoration,
              onSubmitted: (keyword) => _onSearch(weatherState, keyword),
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FilledButton(
                key: Key(Keys.searchButton),
                onPressed: () =>
                    _onSearch(weatherState, _searchKeywordController.text),
                child: const Text('Search'),
              ),
            ),
            Obx(
              () {
                final weather = weatherState.currentWeather.value;
                if (weather == null) {
                  return const SizedBox();
                }
                return WeatherInformation(
                  key: Key(Keys.weatherInformation),
                  weather: weather,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSearch(WeatherState weatherState, String keyword) async {
    if (keyword.isEmpty) {
      return;
    }
    requestExceptionHandler(
      () async => await weatherState.searchWeather(keyword),
    );
    _searchKeywordFocusNode.unfocus();
  }
}

class WeatherScreenBinding implements Bindings {
  @override
  void dependencies() {
    final repository = Get.find<WeatherRepository>();
    Get.lazyPut<WeatherState>(() => WeatherState(repository));
  }
}
