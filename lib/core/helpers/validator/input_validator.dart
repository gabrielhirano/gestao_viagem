mixin InputValidator {
  String? isNotEmpty(String? value, {String? message}) {
    if (value!.isEmpty) return message ?? 'Este campo é obrigatório';
    return null;
  }

  String? hasTwoChars(String? value, {String? message}) {
    if (value!.length < 2) return message ?? 'Digite pelo menos 2 caracteres!';
    return null;
  }

  String? limitOfChars(String? value, int limit, {String? message}) {
    if (value!.length > limit) {
      return message ?? 'Limite máximo de $limit caracteres!';
    }
    return null;
  }

  String? validateNoTrailingSpaces(String value, {String? message}) {
    if (value.trim() != value) {
      return message ?? 'Não pode é permitido espaço vazio apos os caracteres!';
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final function in validators) {
      final validation = function();
      if (validation != null) return validation;
    }
    return null;
  }
}
