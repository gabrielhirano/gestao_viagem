import 'package:gestao_viajem/core/helpers/validator/input_validator.dart';

class PasswordModel with InputValidator {
  final String password;

  PasswordModel(this.password);

  String? validate() {
    List<String? Function()> validators = [
      () => isNotEmpty(password),
      () => hasTwoChars(password),
      () => limitOfChars(password, 20),
      () => validateNoTrailingSpaces(password),
    ];

    return combine(validators);
  }
}
