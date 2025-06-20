import 'package:get_it/get_it.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/data/repository/auth_repository_impl.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';
import 'package:gadgetify/features/auth/domain/use_case/login_use_case.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';

// Create a global instance of GetIt
final sl = GetIt.instance;

void setupDependencies() {
  // --- Auth Feature Dependencies ---

  // Data Source: Handles direct interaction with Hive. It's a singleton because we only need one instance.
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Repository: Implements the contract from the domain layer.
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(sl<AuthLocalDataSource>()),
  );

  // Use Cases: Encapsulate specific business logic.
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<IAuthRepository>()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<IAuthRepository>()),
  );

  // Cubit (ViewModel): It's a factory because we want a new instance for every screen that needs it.
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      // CORRECTED: Pass the correct use case to each parameter.
      signUpUseCase: sl<SignUpUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
    ),
  );
}
