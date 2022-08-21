abstract class LogiRunZoned {
  Future<R> runZoned<R>(R Function() body);
}
