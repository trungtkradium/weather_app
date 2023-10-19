const String defaultErrorMessage =
    'Oops, something went wrong. Please retry again';

const localDbName = 'weather';
const searchHistoryDBFileName = 'search_history';

enum Settings {
  lightMode('Switch Light Mode'),
  darkMode('Switch Dark Mode'),
  useCelsius('Use Celsius Degree'),
  useFahrenheit('Use Fahrenheit Degree');

  const Settings(this.name);

  final String name;
}
