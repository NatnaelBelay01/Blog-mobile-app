import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/network/internet_checker.dart';
import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:blog/features/auth/domian/repository/auth_repository.dart';
import 'package:blog/features/auth/domian/usecases/current_user.dart';
import 'package:blog/features/auth/domian/usecases/user_login_usecase.dart';
import 'package:blog/features/auth/domian/usecases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/repository/blog_repository_imp.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:blog/features/blog/domain/usecase/get_own_blogs.dart';
import 'package:blog/features/blog/domain/usecase/upload_blog_usecase.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonkey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(
    () => Hive.box(
      name: 'blogs',
    ),
  );

  serviceLocator.registerFactory(
    () => InternetConnection(),
  );
  serviceLocator.registerFactory<InternetChecker>(
    () => InternetCheckerImpl(
      checker: serviceLocator(),
    ),
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoriesImp(
      remoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImp(
      supabase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceimpl(
      box: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImp(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      internetChecker: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadBlog(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllBlogs(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetOwnBlogs(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlog: serviceLocator(),
      getAllBlogs: serviceLocator(),
      getOwnBlogs: serviceLocator(),
    ),
  );
}
