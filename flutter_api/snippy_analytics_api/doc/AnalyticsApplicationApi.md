# snippy_analytics_api.api.AnalyticsApplicationApi

## Load the API package
```dart
import 'package:snippy_analytics_api/api.dart';
```

All URIs are relative to *http://localhost:8082*

Method | HTTP request | Description
------------- | ------------- | -------------
[**callSync**](AnalyticsApplicationApi.md#callsync) | **GET** /sync | 
[**hello**](AnalyticsApplicationApi.md#hello) | **GET** /hello | 
[**rootPath**](AnalyticsApplicationApi.md#rootpath) | **GET** / | 


# **callSync**
> String callSync()



### Example 
```dart
import 'package:snippy_analytics_api/api.dart';

final api_instance = AnalyticsApplicationApi();

try { 
    final result = api_instance.callSync();
    print(result);
} catch (e) {
    print('Exception when calling AnalyticsApplicationApi->callSync: $e\n');
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

# **hello**
> String hello(name)



### Example 
```dart
import 'package:snippy_analytics_api/api.dart';

final api_instance = AnalyticsApplicationApi();
final name = name_example; // String | 

try { 
    final result = api_instance.hello(name);
    print(result);
} catch (e) {
    print('Exception when calling AnalyticsApplicationApi->hello: $e\n');
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

# **rootPath**
> String rootPath()



### Example 
```dart
import 'package:snippy_analytics_api/api.dart';

final api_instance = AnalyticsApplicationApi();

try { 
    final result = api_instance.rootPath();
    print(result);
} catch (e) {
    print('Exception when calling AnalyticsApplicationApi->rootPath: $e\n');
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

