import 'package:get/get.dart';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:weather_app/src/constants/constants.dart';

Future<void> registerSqlite() async {
  Get.put<CommonDatabase>(
    sqlite3.openInMemory(),
    tag: localDbName,
    permanent: true,
  );
}
