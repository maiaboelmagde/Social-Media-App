import 'dart:developer';
import 'dart:io';

import 'package:social_media_app/core/constants/supabase_constants.dart';
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
    String path = SupabaseConstants.getUserImagePath(userId);
    // log(
    //   'From "SupabaseImageRemoteDataSourceImpl" Uploading image for userId: $userId to path: $path',
    // );
    try {
      await supabase.storage
          .from(SupabaseConstants.userImagesBucket)
          .upload(
            path,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );
    } on Exception catch (e) {
      // log(
      //   ' From "SupabaseImageRemoteDataSourceImpl" Error uploading image: $e',
      // );
    }
    // log(
    //   ' From "SupabaseImageRemoteDataSourceImpl" Image uploaded successfully to path: $path',
    // );
    return supabase.storage
        .from(SupabaseConstants.userImagesBucket)
        .getPublicUrl(path);
  }
}
