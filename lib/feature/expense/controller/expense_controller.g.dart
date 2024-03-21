// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseController on ExpenseControllerBase, Store {
  Computed<double>? _$totalSpendComputed;

  @override
  double get totalSpend =>
      (_$totalSpendComputed ??= Computed<double>(() => super.totalSpend,
              name: 'ExpenseControllerBase.totalSpend'))
          .value;

  late final _$getExpensesAsyncAction =
      AsyncAction('ExpenseControllerBase.getExpenses', context: context);

  @override
  Future<void> getExpenses() {
    return _$getExpensesAsyncAction.run(() => super.getExpenses());
  }

  @override
  String toString() {
    return '''
totalSpend: ${totalSpend}
    ''';
  }
}
