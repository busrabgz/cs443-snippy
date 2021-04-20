# snippy_core_api.api.UrlControllerApi

## Load the API package
```dart
import 'package:snippy_core_api/api.dart';
```

All URIs are relative to *http://localhost:8089*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create**](UrlControllerApi.md#create) | **POST** /urls | 
[**getUrlForId**](UrlControllerApi.md#geturlforid) | **GET** /urls/{id} | 
[**redirectToURL**](UrlControllerApi.md#redirecttourl) | **GET** /u/{id} | 


# **create**
> String create(body)



### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final body = String(); // String | 

try { 
    final result = api_instance.create(body);
    print(result);
} catch (e) {
    print('Exception when calling UrlControllerApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **String**|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUrlForId**
> String getUrlForId(id)



### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final id = id_example; // String | 

try { 
    final result = api_instance.getUrlForId(id);
    print(result);
} catch (e) {
    print('Exception when calling UrlControllerApi->getUrlForId: $e\n');
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

# **redirectToURL**
> redirectToURL(id)



### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final id = id_example; // String | 

try { 
    api_instance.redirectToURL(id);
} catch (e) {
    print('Exception when calling UrlControllerApi->redirectToURL: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

