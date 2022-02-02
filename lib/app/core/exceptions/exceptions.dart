import 'dart:io';
import 'package:dio/dio.dart';

class CustomException implements Exception {
  final CustomError error;
  CustomException._(this.error);
  @override
  String toString() => "message : $error";
}

class ExceptionHandler {
  factory ExceptionHandler(dynamic error) {
    switch (error.runtimeType) {
      case FormatException:
        throw CustomException._(CustomError.formatException);
      case DioError:
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout ||
            error.type == DioErrorType.sendTimeout ||
            error.type == DioErrorType.cancel) {
          throw CustomException._(CustomError.noInternet);
        } else {
          if (error.response!.statusCode == 409) {
            throw CustomException._(CustomError.conflict);
          } else if (error.response!.statusCode == 400) {
            throw CustomException._(CustomError.alreadyExists);
          } else if (error.response!.statusCode == 404) {
            throw CustomException._(CustomError.wrongCode);
          }
        }
        throw CustomException._(CustomError.unKnown);
      case SocketException:
        throw CustomException._(CustomError.noInternet);
      case HttpException:
        throw CustomException._(CustomError.noInternet);
      default:
        throw CustomException._(CustomError.unKnown);
    }
  }
}

enum CustomError {
  noInternet,
  conflict,
  unKnown,
  alreadyExists,
  alreadySubscribed,
  wrongCode,
  formatException
}
