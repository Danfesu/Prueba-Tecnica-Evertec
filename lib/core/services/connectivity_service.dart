import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectionStream =>
      _connectivity.onConnectivityChanged.map((results) => results.first);

  Future<bool> hasConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }
}
