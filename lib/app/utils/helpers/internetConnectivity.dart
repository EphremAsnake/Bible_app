import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  static final InternetConnectivity _singleton = InternetConnectivity._internal();

  factory InternetConnectivity() {
    return _singleton;
  }

  InternetConnectivity._internal();

  final Connectivity _connectivity = Connectivity();
  bool _isConnected = false;

  Future<void> initialize() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    _isConnected = _isConnectedStatus(result);
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  bool get isConnected => _isConnected;

  void _updateConnectivityStatus(ConnectivityResult result) {
    _isConnected = _isConnectedStatus(result);
  }

  bool _isConnectedStatus(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }
}