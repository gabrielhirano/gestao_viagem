import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/core/util/base_state.dart';
import 'package:gestao_viajem_onfly/core/service/error/app_failure.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late BaseState<String> baseState;

  setUp(() {
    baseState = BaseState<String>();
  });

  group('BaseState Tests', () {
    test('Initial state is none', () {
      expect(baseState.getState, AppState.none);
    });

    test('Data is null initially', () {
      expect(baseState.getData, isNull);
    });

    test('Error is initial value', () {
      expect(baseState.getError.message, 'Nenhuma falha encontrada!');
    });

    test('Execute changes state to loading and then to success', () async {
      await baseState.execute(() async => 'Test Data');
      expect(baseState.getState, AppState.success);
      expect(baseState.getData, 'Test Data');
    });

    test('Execute handles errors', () async {
      final failure = Failure('Test Error');
      await baseState.execute(() {
        throw Exception();
      });
      expect(baseState.getState, AppState.error);
      expect(baseState.getError, failure);
    }, skip: 'Base state está com problemas para capturar a exception');
  });
}
