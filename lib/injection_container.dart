import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/pin_code_provider.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
// import 'features/home/data/repositories/home_repository_impl.dart';
// import 'features/home/domain/repositories/home_repository.dart';
// import 'features/home/presentation/providers/home_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Auth
  // Provider
  // sl.registerFactory(
  //   () => AuthProvider(
  //     login: sl(),
  //   ),
  // );

  // Use cases
  // sl.registerLazySingleton(() => Login(sl())); // TODO: Create Login usecase

  // Repository
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(
  //     dio: sl(),
  //   ),
  // );

  // Data sources - TODO: Create these files
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(client: sl()),
  // );
  // sl.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  // );

  //! Core
  // sl.registerLazySingleton(() => InputConverter()); // TODO: Create file
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance(); // TODO: Add dependency
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

Future<void> initDependencies() async {
  // Features - Auth
  sl.registerFactory(
    () => AuthProvider(sl()),
  );

  sl.registerFactory(
    () => PinCodeProvider(
      sl(),
      LocalAuthentication(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dio: sl(),
    ),
  );

  // Features - Home
  // sl.registerFactory(
  //   () => HomeProvider(sl(), context),
  // ); // TODO: Fix context dependency

  // sl.registerLazySingleton<HomeRepository>(
  //   () => HomeRepositoryImpl(
  //     remoteDataSource: sl(),
  //     networkInfo: sl(),
  //   ),
  // ); // TODO: Implement when datasource is ready

  // sl.registerLazySingleton<HomeRemoteDataSource>(
  //   () => HomeRemoteDataSourceImpl(
  //     client: sl(),
  //     secureStorage: sl(),
  //   ),
  // ); // TODO: Implement HomeRemoteDataSourceImpl

  // External Dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}