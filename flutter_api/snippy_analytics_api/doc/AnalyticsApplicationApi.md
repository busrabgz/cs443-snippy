# snippy_analytics_api.api.AnalyticsApplicationApi

## Load the API package
```dart
import 'package:snippy_analytics_api/api.dart';
```

All URIs are relative to *http://localhost:8082*

Method | HTTP request | Description
------------- | ------------- | -------------
[**callSync**](AnalyticsApplicationApi.md#callsync) | **GET** /sync | Used for healtchecking by the App service.
[**getAnalytics**](AnalyticsApplicationApi.md#getanalytics) | **GET** /analytics/{id} | Gets the access history of the given short URL.
[**rootPath**](AnalyticsApplicationApi.md#rootpath) | **GET** / | Used for healtchecking by the Kubernetes services.
[**saveRequest**](AnalyticsApplicationApi.md#saverequest) | **POST** /analytics/{id} | Logs an incoming request to the given short URL.


# **callSync**
> String callSync()

Used for healtchecking by the App service.

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

# **getAnalytics**
> List<Request> getAnalytics(id, faAuth)

Gets the access history of the given short URL.

### Example 
```dart
import 'package:snippy_analytics_api/api.dart';

final api_instance = AnalyticsApplicationApi();
final id = id_example; // String | 
final faAuth = faAuth_example; // String | 

try { 
    final result = api_instance.getAnalytics(id, faAuth);
    print(result);
} catch (e) {
    print('Exception when calling AnalyticsApplicationApi->getAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **faAuth** | **String**|  | 

### Return type

[**List<Request>**](Request.md)

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

# **saveRequest**
> Object saveRequest(id, body)

Logs an incoming request to the given short URL.

### Example 
```dart
import 'package:snippy_analytics_api/api.dart';

final api_instance = AnalyticsApplicationApi();
final id = id_example; // String | 
final body = int(); // int | 

try { 
    final result = api_instance.saveRequest(id, body);
    print(result);
} catch (e) {
    print('Exception when calling AnalyticsApplicationApi->saveRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **body** | **int**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

