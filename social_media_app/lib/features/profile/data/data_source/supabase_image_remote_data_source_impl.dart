import 'dart:developer';
import 'dart:io';

import 'package:social_media_app/core/constants/supabase_constants.dart';
import 'package:social_media_app/core/errors/exceptions.dart';
import 'package:social_media_app/features/profile/data/data_source/image_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseImageRemoteDataSourceImpl implements ImageRemoteDataSourceBase {
  SupabaseClient supabase;

  SupabaseImageRemoteDataSourceImpl({required this.supabase});
  @override
  Future<String> uploadImage({
    required String userId,
    required File imageFile,
  }) async {
    final path = SupabaseConstants.getUserImagePath(userId);

    try {
      await supabase.storage
          .from(SupabaseConstants.userImagesBucket)
          .upload(
            path,
            imageFile,
            fileOptions: const FileOptions(
              upsert: true,
              contentType: 'image/jpeg',
            ),
          );

      return supabase.storage
          .from(SupabaseConstants.userImagesBucket)
          .getPublicUrl(path);
    } on StorageException catch (e) {
      log(
        'From "SupabaseImageRemoteDataSourceImpl" Supabase storage error: ${e.message}',
      );
      throw ImageUploadException(
        'Could not upload image right now. Please try again later.',
      );
    } on SocketException catch (e) {
      log('From "SupabaseImageRemoteDataSourceImpl" Network error: $e');
      throw ImageUploadException(
        'No internet connection. Please check your network and try again.',
      );
    } catch (e, s) {
      log(
        'From "SupabaseImageRemoteDataSourceImpl" Unexpected upload error: $e\n$s',
      );
      throw ImageUploadException(
        'Something went wrong while uploading the image.',
      );
    }
  }
}
