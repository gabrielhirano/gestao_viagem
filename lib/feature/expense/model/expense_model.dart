import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum ExpenseCategory {
  feeding('alimentação'),
  transport('transporte'),
  hosting('hospedagem'),
  others('outros');

  const ExpenseCategory(this.name);
  final String name;

  static ExpenseCategory fromString(String category) {
    return {
          'alimentação': ExpenseCategory.feeding,
          'transporte': ExpenseCategory.transport,
          'hospedagem': ExpenseCategory.hosting,
        }[category] ??
        ExpenseCategory.others;
  }
}

class ExpenseModel extends Equatable {
  final String id;
  final String name;
  final ExpenseCategory category;
  final double value;
  final DateTime date;
  final String? comment;

  const ExpenseModel({
    required this.id,
    required this.name,
    required this.category,
    required this.value,
    required this.date,
    this.comment,
  });

  @override
  List<Object?> get props {
    return [id, name, category, value, date, comment];
  }

  String get dateFormated {
    DateFormat formato = DateFormat('dd/MM/yyyy');

    return formato.format(date);
  }

  String get hour {
    DateFormat formato = DateFormat('HH:mm');

    return formato.format(date);
  }

  ExpenseModel copyWith({
    String? id,
    String? name,
    ExpenseCategory? category,
    double? value,
    DateTime? date,
    String? comment,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      value: value ?? this.value,
      date: date ?? this.date,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category.name,
      'value': value,
      'date': date.millisecondsSinceEpoch,
      'comment': comment,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'].toString(),
      name: map['name'] as String,
      category: ExpenseCategory.fromString(map['category'] as String),
      value: (map['value'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch((map['date'] as num).toInt()),
      comment: map['comment'] != null ? map['comment'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
