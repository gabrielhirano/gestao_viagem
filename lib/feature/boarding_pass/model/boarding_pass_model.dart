import 'dart:convert';

import 'package:gestao_viajem_onfly/feature/boarding_pass/model/aiport_model.dart';

class BoardingPassModel {
  final String passenger;
  final String number;
  final String airlineCompany;

  final DateTime departure;
  final DateTime arrival;

  final AiportModel origin;
  final AiportModel destination;

  final String seat;
  final String gate;
  final String terminal;
  BoardingPassModel({
    required this.passenger,
    required this.number,
    required this.airlineCompany,
    required this.departure,
    required this.arrival,
    required this.origin,
    required this.destination,
    required this.seat,
    required this.gate,
    required this.terminal,
  });

  BoardingPassModel copyWith({
    String? passenger,
    String? number,
    String? airlineCompany,
    DateTime? departure,
    DateTime? arrival,
    AiportModel? origin,
    AiportModel? destination,
    String? seat,
    String? gate,
    String? terminal,
  }) {
    return BoardingPassModel(
      passenger: passenger ?? this.passenger,
      number: number ?? this.number,
      airlineCompany: airlineCompany ?? this.airlineCompany,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      seat: seat ?? this.seat,
      gate: gate ?? this.gate,
      terminal: terminal ?? this.terminal,
    );
  }

  String get duration {
    Duration difference = arrival.difference(departure);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    String hoursFormatted = hours.toString().padLeft(2, '0');
    String minutesFormatted = minutes.toString().padLeft(2, '0');
    if (hours == 0) return '$minutesFormatted minutos';
    if (minutes == 0) return '$hoursFormatted horas';

    return '$hoursFormatted horas $minutesFormatted minutos';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'passenger': passenger,
      'number': number,
      'airlineCompany': airlineCompany,
      'departure': departure.millisecondsSinceEpoch,
      'arrival': arrival.millisecondsSinceEpoch,
      'origin': origin.toMap(),
      'destination': destination.toMap(),
      'seat': seat,
      'gate': gate,
      'terminal': terminal,
    };
  }

  factory BoardingPassModel.fromMap(Map<String, dynamic> map) {
    return BoardingPassModel(
      passenger: map['passenger'] as String,
      number: map['number'] as String,
      airlineCompany: map['airlineCompany'] as String,
      departure: DateTime.fromMillisecondsSinceEpoch(map['departure'] as int),
      arrival: DateTime.fromMillisecondsSinceEpoch(map['arrival'] as int),
      origin: AiportModel.fromMap(map['origin'] as Map<String, dynamic>),
      destination:
          AiportModel.fromMap(map['destination'] as Map<String, dynamic>),
      seat: map['seat'] as String,
      gate: map['gate'] as String,
      terminal: map['terminal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BoardingPassModel.fromJson(String source) =>
      BoardingPassModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
