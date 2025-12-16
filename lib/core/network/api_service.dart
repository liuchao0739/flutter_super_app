import 'package:dio/dio.dart';
import '../../config/env.dart';

/// 统一的网络服务封装
///
/// - 通过 [useMock] 控制是否走本地 Mock 数据；
/// - 通过 [Env.apiBaseUrl] 适配不同环境；
/// - 对外暴露高层接口（getPosts/postData）与底层 Dio 调用。
class ApiService {
  final Dio _dio = Dio();
  final bool useMock;

  ApiService({this.useMock = true}) {
    _dio.options.baseUrl = Env.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  // GET 请求示例 - 根据 useMock 决定使用 Mock 还是实际接口
  Future<Map<String, dynamic>> getPosts() async {
    if (useMock) {
      await Future.delayed(const Duration(milliseconds: 300));
      return {
        'data': _MockData.posts,
        'success': true,
        'source': 'mock',
      };
    }
    final response = await get('/posts');
    return {
      'data': response.data,
      'success': true,
      'source': 'remote',
    };
  }

  // POST 请求示例
  Future<Map<String, dynamic>> postData(Map<String, dynamic> body) async {
    if (useMock) {
      await Future.delayed(const Duration(milliseconds: 300));
      return {
        'success': true,
        'body': body,
        'message': 'Mock: Data saved successfully',
        'source': 'mock',
      };
    }
    final response = await post('/posts', data: body);
    return {
      'success': true,
      'body': response.data,
      'message': 'Remote: Data saved successfully',
      'source': 'remote',
    };
  }

  // 实际网络请求示例
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception('GET $path failed: ${e.message}');
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('POST $path failed: ${e.message}');
    }
  }
}

/// 内置的一份简单 Mock 数据，替代原来的 modules/network/mock_data.dart。
class _MockData {
  static const List<Map<String, dynamic>> posts = [
    {
      'id': 1,
      'title': 'Mock Post 1',
      'content': 'This is a mock post used for ApiService.getPosts().',
    },
  ];
}


