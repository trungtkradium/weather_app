import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/entity/weather.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';
import 'package:weather_app/src/utils/app_utils.dart';

class WeatherInformation extends StatelessWidget {
  const WeatherInformation({
    super.key,
    required this.weather,
    this.showSearchTime = false,
  });

  final Weather weather;
  final bool showSearchTime;

  @override
  Widget build(BuildContext context) {
    final appConfiguration = AppConfiguration.to;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _weatherIcon,
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(weather.country),
                const SizedBox(height: 8.0),
                Obx(
                  () => _degree(context, appConfiguration.isUseCelsius.value),
                ),
              ],
            ),
          ],
        ),
        Text(
          weather.description.capitalizeFirst ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (showSearchTime)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
              child: Text(
                AppUtils.formatYMEd(
                  DateTime.fromMillisecondsSinceEpoch(weather.createdAt),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }

  CachedNetworkImage get _weatherIcon {
    return CachedNetworkImage(
      imageUrl: weather.iconUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: Colors.red),
    );
  }

  Text _degree(BuildContext context, bool isUseCelsius) {
    String content =
        '${weather.celsiusTemperature} ${AppUtils.getDegreeSymbol(isUseCelsius)}';
    if (!isUseCelsius) {
      content =
          '${AppUtils.fromCelsiusToFahrenheit(weather.celsiusTemperature)}  ${AppUtils.getDegreeSymbol(isUseCelsius)}';
    }
    return Text(
      content,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
