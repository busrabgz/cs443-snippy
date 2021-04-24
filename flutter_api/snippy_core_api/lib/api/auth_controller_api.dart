//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthControllerApi {
  AuthControllerApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// A middle-man for the authentication with the firebase services.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [EmailPassword] emailPassword (required):
  Future<Response> authWithHttpInfo(EmailPassword emailPassword) async {
    // Verify required params are set.
    if (emailPassword == null) {
     throw ApiException(HttpStatus.badRequest, 'Missing required param: emailPassword');
    }

    final path = r'/auth';

    Object postBody = emailPassword;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (
      nullableContentType != null &&
      nullableContentType.toLowerCase().startsWith('multipart/form-data')
    ) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {
    }

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

  /// A middle-man for the authentication with the firebase services.
  ///
  /// Parameters:
  ///
  /// * [EmailPassword] emailPassword (required):
  Future<String> auth(EmailPassword emailPassword) async {
    final response = await authWithHttpInfo(emailPassword);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
        }
    return Future<String>.value(null);
  }

  /// Queries all users if the request comes from admin.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] body (required):
  Future<Response> getUsersWithHttpInfo(String body) async {
    // Verify required params are set.
    if (body == null) {
     throw ApiException(HttpStatus.badRequest, 'Missing required param: body');
    }

    final path = r'/users';

    Object postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    final contentTypes = <String>['application/json'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (
      nullableContentType != null &&
      nullableContentType.toLowerCase().startsWith('multipart/form-data')
    ) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {
    }

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

  /// Queries all users if the request comes from admin.
  ///
  /// Parameters:
  ///
  /// * [String] body (required):
  Future<List<String>> getUsers(String body) async {
    final response = await getUsersWithHttpInfo(body);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<String>') as List)
        .cast<String>()
        .toList(growable: false);
    }
    return Future<List<String>>.value(null);
  }
}
