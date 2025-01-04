abstract class AppException implements Exception {
  final String title;
  final String message;

  const AppException({
    required this.title,
    required this.message,
  });

  static AppException from(Object exception) {
    if (exception is AppException) return exception;
    return const UnknownException();
  }
}

class UnknownException extends AppException {
  const UnknownException()
      : super(
          title: 'Erreur',
          message: 'Une erreur est survenue',
        );
}

class PostNotFoundException extends AppException {
  const PostNotFoundException()
      : super(
          title: 'Erreur',
          message: 'Post introuvable',
        );
}
