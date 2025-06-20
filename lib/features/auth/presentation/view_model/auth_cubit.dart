import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/use_case/login_use_case.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;

  AuthCubit({
    required SignUpUseCase signUpUseCase,
    required LoginUseCase loginUseCase,
  })  : _signUpUseCase = signUpUseCase,
        _loginUseCase = loginUseCase,
        super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    if (password != confirmPassword) {
      emit(const AuthFailure('Passwords do not match'));
      return;
    }
    
    final user = AuthEntity(email: email, password: password);
    final result = await _signUpUseCase(user);

    result.fold(
      (failure) => emit(AuthFailure(failure.error)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await _loginUseCase(email: email, password: password);

    result.fold(
      (failure) => emit(AuthFailure(failure.error)),
      (isSuccess) => emit(AuthSuccess()),
    );
  }
}
