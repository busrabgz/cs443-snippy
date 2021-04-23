//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EmailPassword {
  /// Returns a new [EmailPassword] instance.
  EmailPassword({
    this.email,
    this.password,
  });

  String email;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailPassword &&
     other.email == email &&
     other.password == password;

  @override
  int get hashCode =>
    (email == null ? 0 : email.hashCode) +
    (password == null ? 0 : password.hashCode);

  @override
  String toString() => 'EmailPassword[email=$email, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (email != null) {
      json[r'email'] = email;
    }
    if (password != null) {
      json[r'password'] = password;
    }
    return json;
  }

  /// Returns a new [EmailPassword] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static EmailPassword fromJson(Map<String, dynamic> json) => json == null
    ? null
    : EmailPassword(
        email: json[r'email'],
        password: json[r'password'],
    );

  static List<EmailPassword> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <EmailPassword>[]
      : json.map((v) => EmailPassword.fromJson(v)).toList(growable: true == growable);

  static Map<String, EmailPassword> mapFromJson(Map<String, dynamic> json) {
    final map = <String, EmailPassword>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = EmailPassword.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of EmailPassword-objects as value to a dart map
  static Map<String, List<EmailPassword>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<EmailPassword>>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = EmailPassword.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

