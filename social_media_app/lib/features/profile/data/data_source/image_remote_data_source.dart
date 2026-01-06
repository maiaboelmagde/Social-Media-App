import 'dart:io';

abstract class ImageRemoteDataSourceBase {
  Future<String> uploadImage({
    required String userId,
    required File imageFile
  });
}
