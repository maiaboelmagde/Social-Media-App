class ImageUploadException implements Exception {
  final String message;

  ImageUploadException(this.message);

  @override
  String toString() => message;
}
