import 'dart:convert';

class CustomRequestOptions {
  final String baseUrl;
  final String path;
  final Object? data;
  final String method;

  CustomRequestOptions({
    required this.baseUrl,
    required this.path,
    required this.method,
    this.data,
  });

  CustomRequestOptions copyWith({
    String? baseUrl,
    String? path,
    Object? data,
    String? method,
  }) {
    return CustomRequestOptions(
      baseUrl: baseUrl ?? this.baseUrl,
      path: path ?? this.path,
      data: data ?? this.data,
      method: method ?? this.method,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseUrl': baseUrl,
      'path': path,
      'data': json.encode(data),
      'method': method,
    };
  }

  String toJson() => json.encode(toMap());

  factory CustomRequestOptions.fromMap(Map<String, dynamic> map) {
    return CustomRequestOptions(
      baseUrl: map['baseUrl'] as String,
      path: map['path'] as String,
      data: map['data'] != null ? json.decode(map['data']) : null,
      method: map['method'] as String,
    );
  }

  factory CustomRequestOptions.fromJson(String source) =>
      CustomRequestOptions.fromMap(json.decode(source) as Map<String, dynamic>);
}
