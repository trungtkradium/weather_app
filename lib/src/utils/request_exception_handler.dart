import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/constants/constants.dart';
import 'package:weather_app/src/utils/dialog_utils.dart';

Future<bool> requestExceptionHandler(Future<void> Function() request) async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    DialogUtils.showErrorDialog(
      'Không thể kết nối với internet, vui lòng thử lại sau',
    );
    return false;
  }
  try {
    Get.dialog(loadingDialog);
    await request.call();
    Get.back();
    return true;
  } catch (e) {
    Get.back();
    DialogUtils.showErrorDialog('$defaultErrorMessage\n${e.toString()}');
    return false;
  }
}

Future<T?> requestExceptionHandlerWithType<T>(
  Future<T?> Function() request, {
  bool? showErrorDialog,
}) async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    DialogUtils.showErrorDialog(
      'Không thể kết nối với internet, vui lòng thử lại sau',
    );
    return null;
  }
  try {
    Get.dialog(loadingDialog);
    final result = await request.call();
    Get.back();
    return result;
  } catch (e) {
    Get.back();
    if (showErrorDialog ?? false) {
      DialogUtils.showErrorDialog('$defaultErrorMessage\n${e.toString()}');
    }
    return null;
  }
}
