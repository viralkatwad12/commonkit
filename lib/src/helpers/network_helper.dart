import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/global_config.dart';

abstract class RequestInterceptor {
  Future<http.BaseRequest> onRequest(http.BaseRequest request);
  Future<http.StreamedResponse> onResponse(http.StreamedResponse response);
  Future<void> onError(dynamic error);
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  NetworkException(this.message, {this.statusCode, this.error});

  @override
  String toString() => 'NetworkException: $message (Status Code: $statusCode)';
}

class ApiException implements Exception {
  final String message;
  final int statusCode;
  final dynamic error;

  ApiException(this.message, this.statusCode, {this.error});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class NetworkHelper {
  static final NetworkHelper _instance = NetworkHelper._internal();
  factory NetworkHelper() => _instance;

  http.Client _client;
  final List<RequestInterceptor> _interceptors = [];

  NetworkHelper._internal() : _client = http.Client();

  void addInterceptor(RequestInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  void setClient(http.Client client) {
    _client = client;
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    return _sendRequest('GET', endpoint, headers: headers);
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    return _sendRequest('POST', endpoint, body: body, headers: headers);
  }

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    return _sendRequest('PUT', endpoint, body: body, headers: headers);
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    return _sendRequest('DELETE', endpoint, headers: headers);
  }

  Future<dynamic> upload(String endpoint, {required File file, Map<String, String>? fields, Map<String, String>? headers}) async {
    final url = Uri.parse('${GlobalConfig().baseUrl}$endpoint');
    var request = http.MultipartRequest('POST', url);
    if (headers != null) request.headers.addAll(headers);
    if (fields != null) request.fields.addAll(fields);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    return _send(request);
  }

  Future<dynamic> _sendRequest(String method, String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final url = Uri.parse('${GlobalConfig().baseUrl}$endpoint');
    var request = http.Request(method, url);
    if (headers != null) request.headers.addAll(headers);
    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }
    return _send(request);
  }

  Future<dynamic> _send(http.BaseRequest request) async {
    try {
      for (var interceptor in _interceptors) {
        request = await interceptor.onRequest(request);
      }

      var streamedResponse = await _client.send(request);

      for (var interceptor in _interceptors) {
        streamedResponse = await interceptor.onResponse(streamedResponse);
      }

      return _handleResponse(await http.Response.fromStream(streamedResponse));
    } catch (e) {
      for (var interceptor in _interceptors) {
        await interceptor.onError(e);
      }
      if (e is SocketException) {
        throw NetworkException('No internet connection', error: e);
      } else if (e is ApiException) {
        rethrow;
      } else {
        throw NetworkException('An unexpected error occurred', error: e);
      }
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw ApiException('Request failed', response.statusCode, error: response.body);
    }
  }
}