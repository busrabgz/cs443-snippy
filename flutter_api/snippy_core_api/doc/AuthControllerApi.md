# snippy_core_api.api.AuthControllerApi

## Load the API package
```dart
import 'package:snippy_core_api/api.dart';
```

All URIs are relative to *http://10.0.2.2:8089*

Method | HTTP request | Description
------------- | ------------- | -------------
[**auth**](AuthControllerApi.md#auth) | **POST** /auth | A middle-man for the authentication with the firebase services.
[**getUsers**](AuthControllerApi.md#getusers) | **POST** /users | Queries all users if the request comes from admin.


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

# **getUsers**
> List<String> getUsers(faAuth)

Queries all users if the request comes from admin.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AuthControllerApi();
final faAuth = faAuth_example; // String | 

try { 
    final result = api_instance.getUsers(faAuth);
    print(result);
} catch (e) {
    print('Exception when calling AuthControllerApi->getUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **faAuth** | **String**|  | 

### Return type

**List<String>**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

