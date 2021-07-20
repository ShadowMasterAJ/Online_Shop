class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    print('Error: $message');
    return message;
  }
}
