# snippy_core_api.api.AppApplicationApi

## Load the API package
```dart
import 'package:snippy_core_api/api.dart';
```

All URIs are relative to *http://10.0.2.2:8089*

Method | HTTP request | Description
------------- | ------------- | -------------
[**healthCheck**](AppApplicationApi.md#healthcheck) | **GET** /healthcheck | Returns health status of the all microservices.
[**rootPath**](AppApplicationApi.md#rootpath) | **GET** / | Used for healtchecking by the Kubernetes services.


# **healthCheck**
> String healthCheck()

Returns health status of the all microservices.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AppApplicationApi();

try { 
    final result = api_instance.healthCheck();
    print(result);
} catch (e) {
    print('Exception when calling AppApplicationApi->healthCheck: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootPath**
> String rootPath()

Used for healtchecking by the Kubernetes services.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AppApplicationApi();

try { 
    final result = api_instance.rootPath();
    print(result);
} catch (e) {
    print('Exception when calling AppApplicationApi->rootPath: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

