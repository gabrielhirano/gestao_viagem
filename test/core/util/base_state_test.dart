import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/core/util/base_state.dart';
import 'package:gestao_viajem_onfly/core/service/error/app_failure.dart';
import 'package:mocktail/mocktail.dart';

class MockProcess<T> extends Mock {
  Future<T> call();
}

void main() {
  late BaseState<String> baseState;
  late MockProcess<String> mockProcess;

  setUp(() {
    baseState = BaseState<String>();
    mockProcess = MockProcess<String>();
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
      when(mockProcess).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return '42';
      });

      final future = baseState.execute(mockProcess);

      expect(baseState.getState, AppState.loading);

      await future;

      expect(baseState.getState, AppState.success);
      expect(baseState.getData, '42');
    });

    test('Execute handles errors', () async {
      final failure = Failure('Test Error');
      await baseState.execute(() => throw failure);

      expect(baseState.getState, AppState.error);
      expect(baseState.getError, failure);
    });
  });
}
