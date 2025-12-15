import 'package:dio/dio.dart';
import '../../modules/network/mock_data.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'https://api.example.com';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  // GET 请求示例 - 使用 Mock 数据
  Future<Map<String, dynamic>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'data': MockData.posts, 'success': true};
  }

  // POST 请求示例 - 使用 Mock 数据
  Future<Map<String, dynamic>> postData(Map<String, dynamic> body) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'body': body, 'message': 'Data saved successfully'};
  }

  // 实际网络请求示例（如果需要）
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

