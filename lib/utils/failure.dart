class Failure {
  final String message;
  final String code;

  Failure({required this.message, required this.code});

  @override
  String toString() {
    return 'Failure{message: $message, code: $code}';
  }
}
