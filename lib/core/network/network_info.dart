import 'package:connectivity_plus/connectivity_plus.dart';

// This class is a wrapper around the connectivity_plus package.
// It allows us to abstract the package's implementation from the rest of our app.
abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    // The connection is considered active if it's wifi or mobile data.
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}
