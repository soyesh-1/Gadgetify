import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';
import 'package:gadgetify/features/auth/domain/use_case/login_use_case.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock class for the repository dependency
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  // setUp runs before each test, initializing fresh instances
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  // The parameters we will use for the test
  const loginParams = LoginParams(email: 'test@test.com', password: 'password');

  // Group tests related to LoginUseCase
  group('LoginUseCase', () {
    test(
      'should call authRepository.login with correct parameters and return true on success',
      () async {
        // Arrange: Stub the repository's login method to return a success value (Right(true))
        when(
          () => mockAuthRepository.login(
            email: loginParams.email,
            password: loginParams.password,
          ),
        ).thenAnswer((_) async => const Right(true));

        // Act: Execute the use case
        final result = await loginUseCase(loginParams);

        // Assert: Check if the result is what we expect
        expect(result, const Right(true));

        // Verify: Ensure the repository's login method was called exactly once with the correct data
        verify(
          () => mockAuthRepository.login(
            email: loginParams.email,
            password: loginParams.password,
          ),
        ).called(1);

        // Verify that no other methods on the mock were called
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
