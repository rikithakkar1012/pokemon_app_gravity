class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}
