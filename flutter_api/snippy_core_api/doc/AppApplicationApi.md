# snippy_core_api.api.AppApplicationApi

## Load the API package
```dart
import 'package:snippy_core_api/api.dart';
```

All URIs are relative to *http://localhost:8089*

Method | HTTP request | Description
------------- | ------------- | -------------
[**collections**](AppApplicationApi.md#collections) | **GET** /collections | 
[**healthCheck**](AppApplicationApi.md#healthcheck) | **GET** /healthcheck | Checks health status of the microservices
[**hello**](AppApplicationApi.md#hello) | **GET** /hello | 
[**logs**](AppApplicationApi.md#logs) | **GET** /logs/{id} | 
[**rootPath**](AppApplicationApi.md#rootpath) | **GET** / | 


# **collections**
> String collections()



### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AppApplicationApi();

try { 
    final result = api_instance.collections();
    print(result);
} catch (e) {
    print('Exception when calling AppApplicationApi->collections: $e\n');
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

# **healthCheck**
> healthCheck()

Checks health status of the microservices

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AppApplicationApi();

try { 
    api_instance.healthCheck();
} catch (e) {
    print('Exception when calling AppApplicationApi->healthCheck: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hello**
> String hello(name)



### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AppApplicationApi();
final name = name_example; // String | 

try { 
    final result = api_instance.hello(name);
    print(result);
} catch (e) {
    print('Exception when calling AppApplicationApi->hello: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | [optional] [default to 'World']

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logs**
> String logs(id)



### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = AppApplicationApi();
final id = id_example; // String | 

try { 
    final result = api_instance.logs(id);
    print(result);
} catch (e) {
    print('Exception when calling AppApplicationApi->logs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

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

