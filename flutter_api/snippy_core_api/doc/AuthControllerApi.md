# snippy_core_api.api.AuthControllerApi

## Load the API package
```dart
import 'package:snippy_core_api/api.dart';
```

All URIs are relative to *http://10.0.2.2:8089*

Method | HTTP request | Description
------------- | ------------- | -------------
[**auth**](AuthControllerApi.md#auth) | **POST** /auth | A middle-man for the authentication with the firebase services.


# **auth**
> String auth(emailPassword)

A middle-man for the authentication with the firebase services.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AuthControllerApi();
final emailPassword = EmailPassword(); // EmailPassword | 

try { 
    final result = api_instance.auth(emailPassword);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->auth: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **emailPassword** | [**EmailPassword**](EmailPassword.md)|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

