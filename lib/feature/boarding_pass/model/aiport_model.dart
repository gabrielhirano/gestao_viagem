import 'dart:convert';

class AiportModel {
  String name;
  String acronym;
  String location;
  AiportModel({
    required this.name,
    required this.acronym,
    required this.location,
  });

  AiportModel copyWith({
    String? name,
    String? acronym,
    String? location,
  }) {
    return AiportModel(
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'acronym': acronym,
      'location': location,
    };
  }

  factory AiportModel.fromMap(Map<String, dynamic> map) {
    return AiportModel(
      name: map['name'] as String,
      acronym: map['acronym'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AiportModel.fromJson(String source) =>
      AiportModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
