import 'package:get/get.dart';
import 'package:sqlite3/wasm.dart';
import 'package:weather_app/src/constants/constants.dart';

Future<void> registerSqlite() async {
  await Get.putAsync<CommonDatabase>(
    () async {
      final wasmSqlite = await loadSqlite();
      final weatherDatabase = wasmSqlite.openInMemory();
      return weatherDatabase;
    },
    tag: localDbName,
    permanent: true,
  );
}

Future<WasmSqlite3> loadSqlite() async {
  final wasmSqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
  wasmSqlite3.registerVirtualFileSystem(
    await IndexedDbFileSystem.open(dbName: localDbName),
    makeDefault: true,
  );
  return wasmSqlite3;
}
