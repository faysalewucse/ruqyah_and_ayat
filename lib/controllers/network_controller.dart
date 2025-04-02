import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';

class NetworkController extends GetxController {
  final hasConnection = false.obs;
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  Future<void> initializeNetwork () async {
    await getConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectionType() async {
    late List<ConnectivityResult> connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (err) {
      showErrorToast(message: err.message ?? "Connection Error");
    }
    return _updateState(connectivityResult);
  }

  _updateState(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      debugPrint("No Connectivity");
      hasConnection(false);
    } else {
      debugPrint("Has Connectivity");
      hasConnection(true);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _streamSubscription.cancel();
    super.onClose();
  }
}
