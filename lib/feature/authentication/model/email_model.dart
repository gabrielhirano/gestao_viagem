import 'package:gestao_viajem/core/helpers/validator/input_validator.dart';

class EmailModel with InputValidator {
  final String email;

  EmailModel(this.email);

  String? validate() {
    List<String? Function()> validators = [
      () => isNotEmpty(email),
      () => limitOfChars(email, 20),
      () => validateNoTrailingSpaces(email),
    ];

    return combine(validators);
  }
}
