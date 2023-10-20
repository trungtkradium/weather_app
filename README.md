# weather_app

A new Flutter project for searching weather base on location's name or location's zip code.

## Github: https://github.com/trungtkradium/weather_app 

# Tech

## Flutter version

- Flutter 3.13.6
- Dart 3.1.3

## 3rd service

- OpenWeather: https://openweathermap.org/

## State management

- GetX: https://pub.dev/packages/get

# Project architecture:

```text
weather_app/
├─ integration_test/
│  ├─ test_files/
├─ lib/
│  ├─ src/
│  │  ├─ business/
│  │  ├─ constants/
│  │  ├─ di/
│  │  ├─ entity/
│  │  ├─ presentation/
│  │  │  ├─ components/
│  │  │  ├─ res/
│  │  │  ├─ screens/
│  │  ├─ repository/
│  │  ├─ utils/
│  ├─ main.dart
├─ test/
│  ├─ unit_test/
├─ .gitignore
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
```

# Features:

- Get weather base on location's name or location's zip code.
- See, clear searching history.
- Change app theme mode.
- Change temperature metric.

# Support platform

- Android
- Ios
- MacOs
- Windows
- Linux
- Web (Need to be deployed in https server for using OpenWeather's apis)

# Demo

[Demo Video](https://drive.google.com/file/d/1BIuaPhpTCoUB_aZqCPXM76CBcl4BAf8n/view?usp=sharing)

# How to run

## Start application by command line:

- Use those commands depends on the platform:
  - Web: flutter run --release -d chrome --web-port=5051
  - Mobile: 
    - Get connected device's name by: flutter devices
    - Run: flutter run --release -d $device_name
  - MacOs: flutter run --release -d macos
  - Windows: flutter run --release -d windows

## Install app in android 

- Install app to android device by apk file in: weather_app/apk/app-release.apk

## Run unit test

- Use command line: flutter test test

## Run integration test

- Use command line: flutter test integration_test/test_files

- [Integration Test Video](https://drive.google.com/file/d/1mBPUJO4Vh6GJpxjj4di9w34B2iCp0v_m/view?usp=share_link)

## Generate coverage:
- Install lcov if not exists: brew install lcov
- Use command line:
  - flutter test test --coverage
  - genhtml coverage/lcov.info -o coverage/html
- Tracking coverage by open file: ./coverage/html/index.html