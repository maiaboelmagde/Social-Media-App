import 'package:get_it/get_it.dart';
import 'package:social_media_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:social_media_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:social_media_app/features/auth/domain/repository/auth_repo_base.dart';
import 'package:social_media_app/features/auth/domain/use_case/log_in_use_case.dart';
import 'package:social_media_app/features/auth/domain/use_case/log_out_use_case.dart';
import 'package:social_media_app/features/auth/domain/use_case/register_use_case.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async{
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSource());

  sl.registerLazySingleton<AuthRepoBase>(()=>AuthRepoImpl(remoteDataSource: sl<AuthRemoteDataSource>()));

  sl.registerLazySingleton(()=>RegisterUseCase(authRepo: sl<AuthRepoBase>()));
  sl.registerLazySingleton(()=>LogInUseCase(authRepo: sl<AuthRepoBase>()));
  sl.registerLazySingleton(()=>LogOutUseCase(authRepo: sl<AuthRepoBase>()));
}