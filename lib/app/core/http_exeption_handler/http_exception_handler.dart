import 'dart:io';
import 'package:spanish_bible/app/core/http_exeption_handler/custom_http_exception.dart';
import 'package:http/http.dart';

class HandleHttpException {
  Future<String> getExceptionString(error) async {
    if (error is SocketException) {
      return 'No Internet Connection';
    } else if (error is HttpException) {
      return 'Http Error Occurred';
    } else if (error is FormatException) {
      return 'Unable To Load, Please Try Again!';
    } else if (error is FileMovedException) {
      return error.message.toString();
    } else if (error is BadRequestException) {
      return error.message.toString();
    } else if (error is UnAuthorizedException) {
      return error.message.toString();
    } else if (error is ForbiddenException) {
      return error.message.toString();
    } else if (error is NotFoundException) {
      return error.message.toString();
    } else if (error is NoLongerAvailableException) {
      return error.message.toString();
    } else if (error is BadGatewayException) {
      return error.message.toString();
    } else if (error is InternalServerError) {
      return error.message.toString();
    } else if (error is ConnectionTimedOutException) {
      return error.message.toString();
    } else if (error is FetchDataException) {
      return error.message.toString();
    } else if (error is ClientException) {
      return error.message.toString();
    } else {
      return 'No internet connection, please check your internet connection and try again.';
    }
  }
}
