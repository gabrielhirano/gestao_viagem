import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_viajem/feature/expense/model/expense_model.dart';

void main() {
  group('ExpenseModel', () {
    test('Construtor padrão deve funcionar corretamente', () {
      final expense = ExpenseModel(
        name: 'Compra no supermercado',
        category: ExpenseCategory.feeding,
        value: 50.0,
        date: DateTime.now(),
        comment: 'Compramos comida para a semana',
      );

      expect(expense.name, 'Compra no supermercado');
      expect(expense.category, ExpenseCategory.feeding);
      expect(expense.value, 50.0);
      expect(expense.date, isInstanceOf<DateTime>());
      expect(expense.comment, 'Compramos comida para a semana');
    });

    test('dois ExpenseModel iguais devem ser considerados iguais', () {
      final expense1 = ExpenseModel(
        name: 'Compra no supermercado',
        category: ExpenseCategory.feeding,
        value: 50.0,
        date: DateTime.now(),
        comment: 'Compramos comida para a semana',
      );

      final expense2 = ExpenseModel(
        name: 'Compra no supermercado',
        category: ExpenseCategory.feeding,
        value: 50.0,
        date: DateTime.now(),
        comment: 'Compramos comida para a semana',
      );

      expect(expense1, expense2);
    });

    test('dois ExpenseModel diferentes devem ser considerados diferentes', () {
      final expense1 = ExpenseModel(
        name: 'Compra no supermercado',
        category: ExpenseCategory.feeding,
        value: 50.0,
        date: DateTime.now(),
        comment: 'Compramos comida para a semana',
      );

      final expense2 = ExpenseModel(
        name: 'Compra no mercado',
        category: ExpenseCategory.feeding,
        value: 60.0,
        date: DateTime.now(),
        comment: 'Compramos comida para o mês',
      );

      expect(expense1, isNot(expense2));
    });

    test('toJson deve serializar corretamente', () {
      final expense = ExpenseModel(
        name: 'Compra no supermercado',
        category: ExpenseCategory.feeding,
        value: 50.0,
        date: DateTime.now(),
        comment: 'Compramos comida para a semana',
      );

      final jsonMap = expense.toMap();
      final jsonString = expense.toJson();

      expect(jsonMap['name'], 'Compra no supermercado');
      expect(jsonMap['category'], 'alimentação');
      expect(jsonMap['value'], 50.0);
      expect(jsonMap['comment'], 'Compramos comida para a semana');

      expect(jsonString, isNotEmpty);
    });

    test('fromJson deve desserializar corretamente', () {
      final jsonString = '''
        {
          "name": "Compra no supermercado",
          "category": "alimentação",
          "value": 50.0,
          "date": ${DateTime.now().millisecondsSinceEpoch},
          "comment": "Compramos comida para a semana"
        }
      ''';

      final expense = ExpenseModel.fromJson(jsonString);

      expect(expense.name, 'Compra no supermercado');
      expect(expense.category, ExpenseCategory.feeding);
      expect(expense.value, 50.0);
      expect(expense.comment, 'Compramos comida para a semana');
    });
  });
}
