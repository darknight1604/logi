class LogiException {
  final Object exception;
  LogiException(this.exception);

  String getMessage() => exception.toString();
}
