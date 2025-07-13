import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:mocktail/mocktail.dart';

// Re-use the same mock class
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignUpUseCase signUpUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(mockAuthRepository);
  });

  const authEntity = AuthEntity(
    name: 'Test User',
    email: 'test@test.com',
    password: 'password',
  );

  group('SignUpUseCase', () {
    test('should call authRepository.signup with correct entity', () async {
      // Arrange: Stub the repository's signup method to return success (Right(null))
      // We use `any()` because comparing custom objects can be tricky without equatable setup.
      when(
        () => mockAuthRepository.signup(user: any(named: 'user')),
      ).thenAnswer((_) async => const Right(null));

      // Act: Execute the use case
      final result = await signUpUseCase(authEntity);

      // Assert: Expect a successful result
      expect(result, const Right(null));

      // Verify: Ensure the repository's signup method was called once
      verify(() => mockAuthRepository.signup(user: authEntity)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
