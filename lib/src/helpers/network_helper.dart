import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/global_config.dart';
import 'dart:io';

/// A utility class to simplify HTTP network requests in Flutter apps.
/// Supports GET, POST with JSON, and POST with multiple file uploads.
class NetworkHelper {
  final String? baseUrl;
  final http.Client _client;

  NetworkHelper({this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  String? _effectiveBaseUrl() => baseUrl ?? GlobalConfig().baseUrl;

  Future<dynamic> get(String endpoint) async {
    final effectiveBaseUrl = _effectiveBaseUrl();
    if (effectiveBaseUrl == null) {
      throw Exception('No base URL provided in NetworkHelper or GlobalConfig');
    }
    final url = Uri.parse('$effectiveBaseUrl$endpoint');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  /// Sends a POST request with JSON data or files.
  /// If [files] is provided, sends a multipart request; otherwise, sends JSON.
  Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? body,
        List<File>? files,
      }) async {
    final effectiveBaseUrl = _effectiveBaseUrl();
    if (effectiveBaseUrl == null) {
      throw Exception('No base URL provided in NetworkHelper or GlobalConfig');
    }
    final url = Uri.parse('$effectiveBaseUrl$endpoint');

    if (files != null && files.isNotEmpty) {
      // Handle multipart file upload
      var request = http.MultipartRequest('POST', url);
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } else {
      // Handle regular JSON POST
      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    }
  }
}