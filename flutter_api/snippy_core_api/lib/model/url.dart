//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Url {
  /// Returns a new [Url] instance.
  Url({
    this.id,
    this.url,
  });

  String id;

  String url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Url && other.id == id && other.url == url;

  @override
  int get hashCode =>
      (id == null ? 0 : id.hashCode) + (url == null ? 0 : url.hashCode);

  @override
  String toString() => 'Url[id=$id, url=$url]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (url != null) {
      json[r'url'] = url;
    }
    return json;
  }

  /// Returns a new [Url] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Url fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Url(
          id: json[r'id'],
          url: json[r'url'],
        );

  static List<Url> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <Url>[]
          : json.map((v) => Url.fromJson(v)).toList(growable: true == growable);

  static Map<String, Url> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Url>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = Url.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of Url-objects as value to a dart map
  static Map<String, List<Url>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<Url>>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] =
            Url.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}
