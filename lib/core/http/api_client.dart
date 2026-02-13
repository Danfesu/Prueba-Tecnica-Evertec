import 'package:dio/dio.dart';
import 'package:evertec_technical_test/core/config/constants/environments.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: Environments.baseUrl, // Cambia esto por tu URL base
          connectTimeout: Duration(milliseconds: 5000),
          receiveTimeout: Duration(milliseconds: 5000),
        ),
      );
}
