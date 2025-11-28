import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/global_config.dart';
import 'dart:io';

/// A utility class to simplify HTTP network requests in Flutter apps.
/// Supports GET, POST, PUT, DELETE with JSON, and POST with multiple file uploads.
class NetworkHelper {
  final String? baseUrl;
  final http.Client _client;
  final Map<String, String> _headers;

  NetworkHelper({this.baseUrl, http.Client? client, Map<String, String>? headers})
      : _client = client ?? http.Client(),
        _headers = headers ?? {'Content-Type': 'application/json'};

  String? _effectiveBaseUrl() => baseUrl ?? GlobalConfig().baseUrl;

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final effectiveBaseUrl = _effectiveBaseUrl();
    if (effectiveBaseUrl == null) {
      throw Exception('No base URL provided in NetworkHelper or GlobalConfig');
    }
    final url = Uri.parse('$effectiveBaseUrl$endpoint');
    final response = await _client.get(url, headers: {..._headers, ...?headers});
    return _handleResponse(response);
  }

  Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? body,
        List<File>? files,
        Map<String, String>? headers,
      }) async {
    final effectiveBaseUrl = _effectiveBaseUrl();
    if (effectiveBaseUrl == null) {
      throw Exception('No base URL provided in NetworkHelper or GlobalConfig');
    }
    final url = Uri.parse('$effectiveBaseUrl$endpoint');

    if (files != null && files.isNotEmpty) {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll({..._headers, ...?headers});
      if (body != null) {
        body.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }
      for (var file in files) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response, successStatusCode: 201);
    } else {
      final response = await _client.post(
        url,
        headers: {..._headers, ...?headers},
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response, successStatusCode: 201);
    }
  }

  Future<dynamic> put(
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
      }) async {
    final effectiveBaseUrl = _effectiveBaseUrl();
    if (effectiveBaseUrl == null) {
      throw Exception('No base URL provided in NetworkHelper or GlobalConfig');
    }
    final url = Uri.parse('$effectiveBaseUrl$endpoint');
    final response = await _client.put(
      url,
      headers: {..._headers, ...?headers},
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    final effectiveBaseUrl = _effectiveBaseUrl();
    if (effectiveBaseUrl == null) {
      throw Exception('No base URL provided in NetworkHelper or GlobalConfig');
    }
    final url = Uri.parse('$effectiveBaseUrl$endpoint');
    final response = await _client.delete(url, headers: {..._headers, ...?headers});
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response, {int successStatusCode = 200}) {
    if (response.statusCode == successStatusCode || (successStatusCode == 201 && response.statusCode == 200)) {
      if (response.body.isEmpty) {
        return null;
      }
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to execute request: ${response.statusCode}, ${response.body}');
    }
  }
}