import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/use_case/login_use_case.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock the UseCase dependencies.
class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

// Create dummy "Fake" classes for your custom types so mocktail can work with them.
class FakeLoginParams extends Fake implements LoginParams {}

class FakeAuthEntity extends Fake implements AuthEntity {}

void main() {
  late AuthCubit authCubit;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockLoginUseCase mockLoginUseCase;

  // Register fallback values once for all tests in this file.
  // This is the key to fixing the 'Bad state' error.
  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
    registerFallbackValue(FakeAuthEntity());
  });

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockLoginUseCase = MockLoginUseCase();
    authCubit = AuthCubit(
      signUpUseCase: mockSignUpUseCase,
      loginUseCase: mockLoginUseCase,
    );
  });

  group('AuthCubit', () {
    // Test 1: Successful Login
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        // Arrange: The `any()` matcher will now work correctly because we registered a fallback.
        when(
          () => mockLoginUseCase(any()),
        ).thenAnswer((_) async => const Right(true));
        return authCubit;
      },
      act: (cubit) => cubit.login(email: 'test@test.com', password: 'password'),
      expect:
          () => <AuthState>[AuthLoading(), const AuthSuccess(isLogin: true)],
    );

    // Test 2: Signup Failure (Password Mismatch)
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailure] when signup passwords do not match',
      build: () => authCubit,
      act:
          (cubit) => cubit.signUp(
            name: 'test',
            email: 'test@test.com',
            password: 'password1',
            confirmPassword: 'password2',
          ),
      expect:
          () => <AuthState>[
            AuthLoading(),
            const AuthFailure('Passwords do not match'),
          ],
    );
  });
}
