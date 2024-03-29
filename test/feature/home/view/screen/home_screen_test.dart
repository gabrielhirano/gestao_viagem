import 'dart:convert';

import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gestao_viajem_onfly/core/controller/connectivity_controller.dart';
import 'package:gestao_viajem_onfly/core/service/error/app_failure.dart';
import 'package:gestao_viajem_onfly/core/theme/app_colors.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';

import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/repository/expense_repository.dart';

import 'package:gestao_viajem_onfly/feature/home/view/screen/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

class MockConnectivity extends Mock implements Connectivity {
  @override
  Stream<ConnectivityResult> get onConnectivityChanged => const Stream.empty();
}

void main() {
  late MockConnectivity mockConnectivity;
  late MockExpenseRepository mockExpenseRepository;
  late ExpenseController expenseController;
  late ExpenseModel expenseModel;

  void setUpInjection() {
    final getIt = GetIt.instance;
    getIt.registerSingleton<IAppColors>(AppColors());
    getIt.registerSingleton<ExpenseController>(expenseController);

    getIt.registerSingleton<ConnectivityController>(
      ConnectivityController(mockConnectivity),
    );
  }

  setUpAll(() {
    mockConnectivity = MockConnectivity();
    mockExpenseRepository = MockExpenseRepository();
    expenseController = ExpenseController(mockExpenseRepository);
    expenseModel =
        ExpenseModel.fromJson(jsonEncode(jsonDecode(fixture('expense.json'))));

    when(mockConnectivity.checkConnectivity)
        .thenAnswer((_) async => ConnectivityResult.wifi);

    setUpInjection();
  });

  group('Screen Rendering States Test', () {
    testWidgets(
        'Should show [LoadingState] while waiting for [ExpenseController.getExpenses()] to return a [SuccessState]',
        (
      WidgetTester tester,
    ) async {
      await tester.runAsync(() async {
        when(mockExpenseRepository.getExpenses).thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 2));
          return [expenseModel];
        });

        await tester.pumpWidget(
          const MaterialApp(
            home: HomeScreen(),
          ),
        );

        final loadingState = find.byKey(const ValueKey('LoadingHomeScreen'));

        expect(loadingState, findsOneWidget);

        await Future.delayed(const Duration(seconds: 2));

        await tester.pump();

        final sucessState = find.byKey(const ValueKey('HomeSucessState'));

        expect(sucessState, findsOneWidget);
        expect(expenseController.state.getData, isNotEmpty);
        expect(expenseController.state.getState, AppState.success);
      });
    });

    testWidgets(
        'Should show [LoadingState] while waiting for [ExpenseController.getExpenses()] to return a [EmptyState]',
        (
      WidgetTester tester,
    ) async {
      await tester.runAsync(() async {
        when(mockExpenseRepository.getExpenses).thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 2));
          return [];
        });

        await tester.pumpWidget(
          const MaterialApp(
            home: HomeScreen(),
          ),
        );

        final loadingState = find.byKey(const ValueKey('LoadingHomeScreen'));

        expect(loadingState, findsOneWidget);

        await Future.delayed(const Duration(seconds: 2));

        await tester.pump();

        final emptyState = find.text('Nenhum dado encontrado');

        expect(emptyState, findsOneWidget);
        expect(expenseController.state.getData, isEmpty);
        expect(expenseController.state.getState, AppState.empty);
      });
    });

    testWidgets(
        'Should show [LoadingState] while waiting for [ExpenseController.getExpenses()] to return a [ErrorState]',
        (
      WidgetTester tester,
    ) async {
      await tester.runAsync(() async {
        final mockFailure = Failure('mockFailures');
        when(mockExpenseRepository.getExpenses).thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 2));
          throw mockFailure;
        });

        await tester.pumpWidget(
          const MaterialApp(
            home: HomeScreen(),
          ),
        );

        final loadingState = find.byKey(const ValueKey('LoadingHomeScreen'));

        expect(loadingState, findsOneWidget);

        await Future.delayed(const Duration(seconds: 2));

        await tester.pump();

        final errorState = find.text('Tela de erro');

        expect(errorState, findsOneWidget);
        expect(expenseController.state.getError.message,
            equals(mockFailure.message));
        expect(expenseController.state.getState, AppState.error);
      });
    });
  });
}
