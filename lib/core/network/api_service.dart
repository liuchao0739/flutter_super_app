import 'package:dio/dio.dart';
import '../../config/constants.dart';
import 'api_error_handler.dart';

/// ApiService
///
/// 统一的网络请求服务，封装 Dio，提供统一的错误处理和日志记录
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  bool _initialized = false;

  /// 初始化网络服务
  /// TODO(prod): 添加拦截器、Token 管理、请求重试等
  Future<void> init() async {
    if (_initialized) return;

    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // 添加请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO(prod): 添加 Token
          // final token = StorageService.getToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          handler.next(options);
        },
        onResponse: (response, handler) {
          // TODO(prod): 统一处理响应数据格式
          handler.next(response);
        },
        onError: (error, handler) {
          _handleError(error);
          handler.next(error);
        },
      ),
    );

    // 添加日志拦截器（仅 Debug 模式）
    // TODO(prod): 使用 logger 包统一日志
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    _initialized = true;
  }

  /// GET 请求
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _ensureInitialized();
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// POST 请求
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _ensureInitialized();
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// PUT 请求
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _ensureInitialized();
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// DELETE 请求
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _ensureInitialized();
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// 下载文件
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
  }) async {
    _ensureInitialized();
    try {
      return await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        options: options,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// 上传文件
  Future<Response<T>> uploadFile<T>(
    String path,
    String filePath, {
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _ensureInitialized();
    try {
      final formData = FormData.fromMap({
        ...?data,
        'file': await MultipartFile.fromFile(filePath),
      });

      return await _dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw Exception('ApiService 未初始化，请先调用 init()');
    }
  }

  /// 统一错误处理
  void _handleError(dynamic error) {
    ApiErrorHandler.handleError(error);
    // 错误已由 ApiErrorHandler 记录日志
  }

  /// 获取 Dio 实例（用于高级用法）
  Dio get dio => _dio;
}

/// 网络请求结果封装
class ApiResult<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? code;

  ApiResult({
    required this.success,
    this.data,
    this.message,
    this.code,
  });

  factory ApiResult.success(T data, {String? message, int? code}) {
    return ApiResult(
      success: true,
      data: data,
      message: message,
      code: code,
    );
  }

  factory ApiResult.failure(String message, {int? code}) {
    return ApiResult(
      success: false,
      message: message,
      code: code,
    );
  }

  factory ApiResult.fromResponse(Response response) {
    // TODO(prod): 根据实际 API 响应格式解析
    // 假设响应格式为: { "code": 200, "data": {...}, "message": "success" }
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final code = data['code'] as int?;
      final success = code == 200;
      final message = data['message'] as String?;
      final resultData = data['data'] as T?;

      return ApiResult(
        success: success,
        data: resultData,
        message: message,
        code: code,
      );
    }

    return ApiResult.success(response.data as T);
  }
}
