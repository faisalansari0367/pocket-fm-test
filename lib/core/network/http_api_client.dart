import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

class HttpApiClient {
  HttpApiClient({
    http.Client? client,
    Uri? baseUri,
    this.timeout = const Duration(seconds: 15),
  }) : _client = client ?? http.Client(),
       _baseUri = baseUri ?? Uri.https('fakestoreapi.com', '/');

  final http.Client _client;
  final Uri _baseUri;
  final Duration timeout;

  Future<Object?> getJson(String path) async {
    final uri = _baseUri.resolve(path);
    late final http.Response response;

    try {
      response = await _client.get(uri).timeout(timeout);
    } on TimeoutException catch (error) {
      throw ApiException(
        'The request timed out. Please try again.',
        cause: error,
      );
    } on http.ClientException catch (error) {
      throw ApiException('Could not connect to the server.', cause: error);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'The server returned an error (${response.statusCode}).',
      );
    }

    try {
      return jsonDecode(response.body);
    } on FormatException catch (error) {
      throw ApiException('The server returned invalid JSON.', cause: error);
    }
  }

  void close() => _client.close();
}
