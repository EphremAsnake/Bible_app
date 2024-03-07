import 'package:get/get.dart';

enum ApiState { loading, success, error }

class ApiStateHandler<T> extends GetxController {
  final _apiState = ApiState.loading.obs;
  final _data = Rx<T?>(null);
  final _error = Rx<String?>(null);

  ApiState get apiState => _apiState.value;
  T? get data => _data.value;
  String? get error => _error.value;

  void setLoading() {
    _apiState.value = ApiState.loading;
  }

  void setSuccess(T responseData) {
    _apiState.value = ApiState.success;
    _data.value = responseData;
    _error.value = null;
  }

  void setError(String errorMessage) {
    _apiState.value = ApiState.error;
    _data.value = null;
    _error.value = errorMessage;
  }
}