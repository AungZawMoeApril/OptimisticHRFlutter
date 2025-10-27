import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';

import 'features/announcement/data/models/announcement_model.dart';

import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/pin_code_provider.dart';

import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/presentation/providers/home_provider.dart';

import 'features/announcement/domain/repositories/announcement_repository.dart';
import 'features/announcement/data/repositories/announcement_repository_impl.dart';
import 'features/announcement/data/datasources/announcement_remote_data_source.dart';
import 'features/announcement/presentation/bloc/announcement_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  sl.registerFactory(() => AuthProvider(sl()));

  sl.registerFactory(() => PinCodeProvider(sl(), LocalAuthentication()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dio: sl(),
      storage: sl(),
    ),
  );

  //! Features - Home
  sl.registerFactory(() => HomeProvider(sl(), sl()));

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Features - Announcement
  // Bloc
  sl.registerFactory(
    () => AnnouncementBloc(sl()),
  );

  // Repository
  sl.registerLazySingletonAsync<Box<AnnouncementModel>>(
    () async => Hive.openBox<AnnouncementModel>('announcements'),
  );
  
  sl.registerLazySingleton<AnnouncementRepository>(
    () => AnnouncementRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      announcementsBox: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<AnnouncementRemoteDataSource>(
    () => AnnouncementRemoteDataSourceImpl(),
  );

  //! External Dependencies
  // Dio
  sl.registerLazySingleton(() => Dio());

  // Secure Storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Internet Connection Checker
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Local Authentication
  sl.registerLazySingleton(() => LocalAuthentication());
}