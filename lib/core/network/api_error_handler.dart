import 'package:dio/dio.dart';
import '../crash/crash_service.dart';

/// ApiErrorHandler
///
/// 统一的 API 错误处理工具类
class ApiErrorHandler {
  /// 处理 DioException 错误
  static String handleDioError(DioException error) {
    String message = '网络请求失败';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = '请求超时，请检查网络连接';
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          message = _handleStatusCode(statusCode, error.response?.data);
        }
        break;
      case DioExceptionType.cancel:
        message = '请求已取消';
        break;
      case DioExceptionType.unknown:
        message = '网络连接失败，请检查网络设置';
        break;
      default:
        message = '未知错误';
    }

    // 记录错误日志
    CrashService.logError('ApiError: $message', error.stackTrace);

    return message;
  }

  /// 处理 HTTP 状态码
  static String _handleStatusCode(int statusCode, dynamic data) {
    if (statusCode >= 500) {
      return '服务器错误，请稍后重试';
    } else if (statusCode == 401) {
      return '未授权，请重新登录';
    } else if (statusCode == 403) {
      return '无权限访问';
    } else if (statusCode == 404) {
      return '请求的资源不存在';
    } else if (statusCode >= 400) {
      // 尝试从响应数据中提取错误信息
      if (data is Map<String, dynamic>) {
        final errorMsg = data['message'] as String?;
        if (errorMsg != null && errorMsg.isNotEmpty) {
          return errorMsg;
        }
      }
      return '请求失败: $statusCode';
    }
    return '未知错误: $statusCode';
  }

  /// 处理通用错误
  static String handleError(dynamic error) {
    if (error is DioException) {
      return handleDioError(error);
    } else {
      CrashService.logError(error, null);
      return '发生未知错误: $error';
    }
  }
}
