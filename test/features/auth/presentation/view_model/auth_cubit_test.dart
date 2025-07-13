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

void main() {
  late AuthCubit authCubit;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockLoginUseCase = MockLoginUseCase();
    authCubit = AuthCubit(
      signUpUseCase: mockSignUpUseCase,
      loginUseCase: mockLoginUseCase,
    );
    // Register a fallback value for AuthEntity for mocktail to work with it.
    registerFallbackValue(const AuthEntity(name: '', email: '', password: ''));
  });

  // Test Group for all AuthCubit tests
  group('AuthCubit', () {
    // Test 1: Successful Login
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        // Arrange: When the login use case is called with any parameters, return success.
        when(
          () => mockLoginUseCase(any()),
        ).thenAnswer((_) async => const Right(true));
        return authCubit;
      },
      // Act: Call the login method on the cubit.
      act: (cubit) => cubit.login(email: 'test@test.com', password: 'password'),
      // Assert: Expect this exact sequence of states.
      expect:
          () => <AuthState>[AuthLoading(), const AuthSuccess(isLogin: true)],
    );

    // Test 2: Signup Failure (Password Mismatch)
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailure] when signup passwords do not match',
      build: () => authCubit,
      // Act: Call signUp with mismatched passwords.
      act:
          (cubit) => cubit.signUp(
            name: 'test',
            email: 'test@test.com',
            password: 'password1',
            confirmPassword: 'password2',
          ),
      // Assert: Expect a loading state, then a failure state with the correct message.
      expect:
          () => <AuthState>[
            AuthLoading(),
            const AuthFailure('Passwords do not match'),
          ],
    );
  });
}
