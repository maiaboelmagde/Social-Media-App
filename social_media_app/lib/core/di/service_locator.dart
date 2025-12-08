import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:social_media_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';
import 'package:social_media_app/features/auth/domain/use_case/log_in_use_case.dart';
import 'package:social_media_app/features/auth/domain/use_case/log_out_use_case.dart';
import 'package:social_media_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:social_media_app/features/auth/domain/use_case/reset_password_usecase.dart';
import 'package:social_media_app/features/posts/data/data_source/posts_data_source.dart';
import 'package:social_media_app/features/posts/data/repository/posts_repo_impl.dart';
import 'package:social_media_app/features/posts/domain/repository/posts_repo_base.dart';
import 'package:social_media_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:social_media_app/features/posts/domain/use_cases/get_posts_stream_use_case.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async{
  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton(FirebaseFirestore.instance);

  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSource());
  sl.registerLazySingleton<PostsDataSource>(()=>PostsDataSource(auth: sl(), fireStore: sl()));

  sl.registerLazySingleton<AuthRepoBase>(()=>AuthRepoImpl(remoteDataSource: sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton<PostsRepoBase>(()=>PostsRepoImpl(postsDataSource: sl<PostsDataSource>()));

  sl.registerLazySingleton(()=>RegisterUseCase(authRepo: sl<AuthRepoBase>()));
  sl.registerLazySingleton(()=>LogInUseCase(authRepo: sl<AuthRepoBase>()));
  sl.registerLazySingleton(()=>LogOutUseCase(authRepo: sl<AuthRepoBase>()));
  sl.registerLazySingleton(()=>ResetPasswordUsecase(authRepo: sl<AuthRepoBase>()));

  sl.registerLazySingleton(()=>AddPostUseCase(postsRepo: sl<PostsRepoBase>()));
  sl.registerLazySingleton(()=>GetPostsStreamUseCase(postsRepo: sl<PostsRepoBase>()));
}
