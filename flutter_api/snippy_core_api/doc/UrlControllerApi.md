# snippy_core_api.api.UrlControllerApi

## Load the API package
```dart
import 'package:snippy_core_api/api.dart';
```

All URIs are relative to *http://snippy.me*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create**](UrlControllerApi.md#create) | **POST** /urls | Creates a shortened URL for the user.
[**createNamed**](UrlControllerApi.md#createnamed) | **POST** /namedUrls | Creates a shortened URL with the defined id for the user.
[**getUrlForId**](UrlControllerApi.md#geturlforid) | **GET** /urls/{id} | Gets the original URL from the shortened URL.
[**getUrlForUser**](UrlControllerApi.md#geturlforuser) | **GET** /urls | Queries the urls created by the current user.
[**getUrlForUserFromAdmin**](UrlControllerApi.md#geturlforuserfromadmin) | **POST** /adminUrls | Queries the urls of a user with the given email to admin.
[**redirectToURL**](UrlControllerApi.md#redirecttourl) | **GET** /u/{id} | Redirects a shortened URL to the original URL


# **create**
> String create(body, faAuth)

Creates a shortened URL for the user.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final body = String(); // String | 
final faAuth = faAuth_example; // String | 

try { 
    final result = api_instance.create(body, faAuth);
    print(result);
} catch (e) {
    print('Exception when calling UrlControllerApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **String**|  | 
 **faAuth** | **String**|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: text/plain
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createNamed**
> String createNamed(faAuth, url)

Creates a shortened URL with the defined id for the user.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final faAuth = faAuth_example; // String | 
final url = Url(); // Url | 

try { 
    final result = api_instance.createNamed(faAuth, url);
    print(result);
} catch (e) {
    print('Exception when calling UrlControllerApi->createNamed: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **faAuth** | **String**|  | 
 **url** | [**Url**](Url.md)|  | 

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

Gets the original URL from the shortened URL.

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

# **getUrlForUser**
> List<Url> getUrlForUser(faAuth, page, size, sort)

Queries the urls created by the current user.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final faAuth = faAuth_example; // String | 
final page = 56; // int | Zero-based page index (0..N)
final size = 56; // int | The size of the page to be returned
final sort = []; // List<String> | Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported.

try { 
    final result = api_instance.getUrlForUser(faAuth, page, size, sort);
    print(result);
} catch (e) {
    print('Exception when calling UrlControllerApi->getUrlForUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **faAuth** | **String**|  | 
 **page** | **int**| Zero-based page index (0..N) | [optional] [default to 0]
 **size** | **int**| The size of the page to be returned | [optional] [default to 20]
 **sort** | [**List<String>**](String.md)| Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported. | [optional] [default to const []]

### Return type

[**List<Url>**](Url.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUrlForUserFromAdmin**
> List<Url> getUrlForUserFromAdmin(faAuth, body)

Queries the urls of a user with the given email to admin.

### Example 
```dart
import 'package:snippy_core_api/api.dart';

final api_instance = UrlControllerApi();
final faAuth = faAuth_example; // String | 
final body = String(); // String | 

try { 
    final result = api_instance.getUrlForUserFromAdmin(faAuth, body);
    print(result);
} catch (e) {
    print('Exception when calling UrlControllerApi->getUrlForUserFromAdmin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **faAuth** | **String**|  | 
 **body** | **String**|  | 

### Return type

[**List<Url>**](Url.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: text/plain
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **redirectToURL**
> redirectToURL(id)

Redirects a shortened URL to the original URL

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

