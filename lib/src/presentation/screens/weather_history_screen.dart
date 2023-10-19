import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/business/weather_state.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';
import 'package:weather_app/src/presentation/components/base_app_bar.dart';
import 'package:weather_app/src/presentation/components/weather_information.dart';
import 'package:weather_app/src/presentation/res/keys.dart';
import 'package:weather_app/src/repository/weather/weather_repository.dart';
import 'package:weather_app/src/utils/de_bouncer.dart';

class WeatherHistoryScreen extends StatefulWidget {
  const WeatherHistoryScreen({super.key});

  static const String routeName = '/weather_history_screen';

  @override
  State<WeatherHistoryScreen> createState() => _WeatherHistoryScreenState();
}

class _WeatherHistoryScreenState extends State<WeatherHistoryScreen> {
  int _page = 0;
  final int _pageSize = 10;
  bool _isLastPage = false;

  final _isLoading = false.obs;

  final ScrollController _scrollController = ScrollController();

  final DeBouncer _loadMoreDeBouncer =
      DeBouncer(delay: const Duration(milliseconds: 200));

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollControllerListener);
    _fetchSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    final appConfiguration = AppConfiguration.to;
    final weatherState = WeatherState.to;
    return Scaffold(
      appBar: BaseAppBar(
        appConfiguration: appConfiguration,
        title: const Text('Weather History'),
        actions: [
          Tooltip(
            key: Key(Keys.appBarClearAllSearchHistoryButton),
            preferBelow: true,
            message: 'Clear History',
            child: IconButton(
              onPressed: weatherState.clearSearchWeatherHistory,
              icon: const Tooltip(
                preferBelow: true,
                message: 'Clear History',
                child: Icon(Icons.clear_all),
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final weather = weatherState.searchHistory[index];
            return WeatherInformation(weather: weather, showSearchTime: true);
          },
          itemCount: weatherState.searchHistory.length,
        ),
      ),
    );
  }

  void _scrollControllerListener() {
    _loadMoreDeBouncer.call(() {
      final double nextPageTrigger =
          0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger &&
          !_isLoading.value &&
          !_isLastPage) {
        _page++;
        _fetchSearchHistory(page: _page);
      }
    });
  }

  Future<void> _fetchSearchHistory({int page = 1}) async {
    if (page == 1) {
      _page = 1;
      _isLastPage = false;
    }
    _isLoading.value = true;
    final weatherState = WeatherState.to;
    final weathers = weatherState.getSearchWeatherHistory(
      page,
      pageSize: _pageSize,
    );
    _isLoading.value = false;
    _isLastPage = weathers.isEmpty || weathers.length < _pageSize;
  }
}

class WeatherHistoryScreenBinding implements Bindings {
  @override
  void dependencies() {
    final repository = Get.find<WeatherRepository>();
    Get.lazyPut<WeatherState>(() => WeatherState(repository));
  }
}
