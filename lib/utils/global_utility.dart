import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class GlobalUtility {
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      debugPrint("mobile true");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      debugPrint("wifi true");
      return true;
    }
    return false;
  }
}
