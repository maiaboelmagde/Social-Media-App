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
    await supabase.storage
        .from(SupabaseConstants.userImagesBucket)
        .upload(path, imageFile, fileOptions: const FileOptions(upsert: true));

    return supabase.storage
        .from(SupabaseConstants.userImagesBucket)
        .getPublicUrl(path);
  }
}
