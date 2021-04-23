//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AnalyticsApplicationApi {
  AnalyticsApplicationApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /sync' operation and returns the [Response].
  Future<Response> callSyncWithHttpInfo() async {
    final path = r'/sync';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType =
        contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (nullableContentType != null &&
        nullableContentType.toLowerCase().startsWith('multipart/form-data')) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {}

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<String> callSync() async {
    final response = await callSyncWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String')
          as String;
    }
    return Future<String>.value(null);
  }

  /// Performs an HTTP 'GET /analytics/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getAnalyticsWithHttpInfo(String id) async {
    // Verify required params are set.
    if (id == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: id');
    }

    final path = r'/analytics/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType =
        contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (nullableContentType != null &&
        nullableContentType.toLowerCase().startsWith('multipart/form-data')) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {}

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<List<Request>> getAnalytics(String id) async {
    final response = await getAnalyticsWithHttpInfo(id);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<Request>')
              as List)
          .cast<Request>()
          .toList(growable: false);
    }
    return Future<List<Request>>.value(null);
  }

  /// Performs an HTTP 'GET /hello' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] name:
  Future<Response> helloWithHttpInfo({String name}) async {
    // Verify required params are set.

    final path = r'/hello';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (name != null) {
      queryParams
          .addAll(_convertParametersForCollectionFormat('', 'name', name));
    }

    final contentTypes = <String>[];
    final nullableContentType =
        contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (nullableContentType != null &&
        nullableContentType.toLowerCase().startsWith('multipart/form-data')) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {}

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [String] name:
  Future<String> hello({String name}) async {
    final response = await helloWithHttpInfo(name: name);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String')
          as String;
    }
    return Future<String>.value(null);
  }

  /// Performs an HTTP 'GET /' operation and returns the [Response].
  Future<Response> rootPathWithHttpInfo() async {
    final path = r'/';

    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>[];
    final nullableContentType =
        contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (nullableContentType != null &&
        nullableContentType.toLowerCase().startsWith('multipart/form-data')) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {}

    return await apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  Future<String> rootPath() async {
    final response = await rootPathWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String')
          as String;
    }
    return Future<String>.value(null);
  }

  /// Performs an HTTP 'POST /analytics/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] body (required):
  Future<Response> saveRequestWithHttpInfo(String id, String body) async {
    // Verify required params are set.
    if (id == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: id');
    }
    if (body == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: body');
    }

    final path = r'/analytics/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    Object postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType =
        contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (nullableContentType != null &&
        nullableContentType.toLowerCase().startsWith('multipart/form-data')) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {}

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] body (required):
  Future<Object> saveRequest(String id, String body) async {
    final response = await saveRequestWithHttpInfo(id, body);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Object')
          as Object;
    }
    return Future<Object>.value(null);
  }
}
