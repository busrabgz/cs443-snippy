//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Request {
  /// Returns a new [Request] instance.
  Request({
    this.incomingTime,
    this.outgoingTime,
  });

  int incomingTime;

  int outgoingTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Request &&
     other.incomingTime == incomingTime &&
     other.outgoingTime == outgoingTime;

  @override
  int get hashCode =>
    (incomingTime == null ? 0 : incomingTime.hashCode) +
    (outgoingTime == null ? 0 : outgoingTime.hashCode);

  @override
  String toString() => 'Request[incomingTime=$incomingTime, outgoingTime=$outgoingTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (incomingTime != null) {
      json[r'incomingTime'] = incomingTime;
    }
    if (outgoingTime != null) {
      json[r'outgoingTime'] = outgoingTime;
    }
    return json;
  }

  /// Returns a new [Request] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Request fromJson(Map<String, dynamic> json) => json == null
    ? null
    : Request(
        incomingTime: json[r'incomingTime'],
        outgoingTime: json[r'outgoingTime'],
    );

  static List<Request> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <Request>[]
      : json.map((v) => Request.fromJson(v)).toList(growable: true == growable);

  static Map<String, Request> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Request>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = Request.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of Request-objects as value to a dart map
  static Map<String, List<Request>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<Request>>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = Request.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

