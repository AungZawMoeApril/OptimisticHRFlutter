import 'package:get_it/get_it.dart';
import '../domain/repositories/time_attendance_repository.dart';
import '../data/repositories/time_attendance_repository_impl.dart';
import '../presentation/viewmodels/time_attendance_viewmodel.dart';

Future<void> initTimeAttendance() async {
  final sl = GetIt.instance;

  // ViewModels
  sl.registerFactory(
    () => TimeAttendanceViewModel(sl()),
  );

  // Repositories
  sl.registerLazySingleton<TimeAttendanceRepository>(
    () => TimeAttendanceRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      secureStorage: sl(),
    ),
  );
}