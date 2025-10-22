import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'providers/app_state_provider.dart';
import 'providers/profile_provider.dart';
import 'storage/boxes.dart';
import 'storage/storage_service.dart';
import 'storage/storage_migration.dart';
import 'data/repositories/profile_repository.dart';
import 'data/sources/local/profile_local_data_source.dart';
import 'network/api_client.dart';
import '../features/auth/domain/repositories/auth_repository.dart' as auth;
import '../features/auth/data/repositories/auth_repository_impl.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core services
  final storageService = StorageService();
  await StorageService.initialize();
  await Boxes.initialize();
  sl.registerLazySingleton<IStorageService>(() => storageService);

  // Migration
  final migrationManager = StorageMigrationManager(sl<IStorageService>());
  await migrationManager.migrateAllData();

  // API Client without auth
  final apiClient = ApiClient();
  sl.registerLazySingleton(() => apiClient);

  // Auth Repository with API client
  sl.registerLazySingleton<auth.AuthRepository>(
    () => AuthRepositoryImpl(dio: apiClient.dio),
  );

  // Update API client with auth repository
  apiClient.setAuthRepository(sl<auth.AuthRepository>());

  // Data sources
  sl.registerLazySingleton(() => ProfileLocalDataSource());

  // Repositories
  sl.registerLazySingleton(() => ProfileRepository(sl<ProfileLocalDataSource>()));

  // Providers
  sl.registerLazySingleton(() => AppStateProvider(sl<IStorageService>()));
  sl.registerLazySingleton(() => ProfileProvider(sl<ProfileRepository>()));
}

List<ChangeNotifierProvider> getProviders() {
  return [
    ChangeNotifierProvider<AppStateProvider>(
      create: (_) => sl<AppStateProvider>(),
    ),
    ChangeNotifierProvider<ProfileProvider>(
      create: (_) => sl<ProfileProvider>(),
    ),
  ];
}