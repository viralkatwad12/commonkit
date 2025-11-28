import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:commonkit/src/helpers/network_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'network_helper_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('NetworkHelper', () {
    late NetworkHelper network;
    late MockClient mockClient;
    final baseUrl = 'https://api.example.com';

    setUp(() {
      mockClient = MockClient();
      network = NetworkHelper(baseUrl: baseUrl, client: mockClient);
    });

    test('get request succeeds', () async {
      when(mockClient.get(Uri.parse('$baseUrl/test'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{"data": "test"}', 200));

      final result = await network.get('/test');
      expect(result['data'], 'test');
    });

    test('get request fails', () async {
      when(mockClient.get(Uri.parse('$baseUrl/test'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => network.get('/test'), throwsException);
    });

    test('post request succeeds', () async {
      when(mockClient.post(Uri.parse('$baseUrl/test'), headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{"data": "created"}', 201));

      final result = await network.post('/test', body: {'key': 'value'});
      expect(result['data'], 'created');
    });

    test('put request succeeds', () async {
      when(mockClient.put(Uri.parse('$baseUrl/test'), headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{"data": "updated"}', 200));

      final result = await network.put('/test', body: {'key': 'value'});
      expect(result['data'], 'updated');
    });

    test('delete request succeeds', () async {
      when(mockClient.delete(Uri.parse('$baseUrl/test'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 200));

      final result = await network.delete('/test');
      expect(result, isNull);
    });

  });
}