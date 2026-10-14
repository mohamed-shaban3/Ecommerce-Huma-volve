import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleDioError(exception);
    } else if (exception is Exception) {
      return _handleRemoteError(exception.toString());
    } else if (exception is String) {
      return _handleRemoteError(exception);
    } else {
      return const Failure(failureMessage: 'Un Expected Error');
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure(
          failureMessage: 'Connection timed out. The server is not responding.',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.statusMessage ?? "";
        return _handleRemoteError("Error $statusCode: $message");
      case DioExceptionType.connectionError:
        return const Failure(
          failureMessage: 'No internet connection. Please check your network.',
        );
      case DioExceptionType.cancel:
        return const Failure(failureMessage: 'Request was cancelled.');
      default:
        return _handleRemoteError(error.message ?? error.toString());
    }
  }

  static Failure _handleRemoteError(String message) {
    if (message.contains('401') ||
        message.contains('Unauthorized') ||
        message.contains('Unauthenticated')) {
      return const Failure(
        failureMessage: 'Your session has expired. Please login again.',
      );
    } else if (message.contains('403') || message.contains('Forbidden')) {
      return const Failure(
        failureMessage: 'You don\'t have permission to perform this action.',
      );
    } else if (message.contains('404') || message.contains('Not Found')) {
      return const Failure(
        failureMessage: 'The requested resource was not found.',
      );
    } else if (message.contains('500') ||
        message.contains('Internal Server Error')) {
      return const Failure(
        failureMessage:
            'Our server is having trouble. Please try again in a few minutes.',
      );
    } else if (message.isNotEmpty &&
        !message.contains('400') &&
        !message.contains('Exception')) {
      return Failure(failureMessage: message);
    } else if (message.contains('422') ||
        message.contains('Unprocessable Content')) {
      return const Failure(
        failureMessage:
            'Invalid information provided. Please check your inputs.',
      );
    } else if (message.contains('SocketException') ||
        message.contains('Connection failed') ||
        message.contains('HandshakeException')) {
      return const Failure(
        failureMessage: 'No internet connection. Please check your network.',
      );
    } else if (message.contains('Timeout') || message.contains('Deadline')) {
      return const Failure(
        failureMessage: 'Connection timed out. The server is not responding.',
      );
    } else if (message.contains('TypeError') ||
        message.contains('FormatException')) {
      return const Failure(
        failureMessage:
            'We encountered a technical issue while processing data.',
      );
    } else {
      return const Failure(failureMessage: 'Unexpected error occurred.');
    }
  }
}
