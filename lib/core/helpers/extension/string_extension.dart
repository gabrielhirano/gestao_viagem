extension StringExtension on String {
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;

  String? get extractBaseEndPoint {
    RegExp regex = RegExp(r'(?<=api\/)(.*?)(?=\/)');
    RegExpMatch? match = regex.firstMatch(this);

    if (match != null) {
      return '/${match.group(0)}';
    }

    return null;
  }
}
