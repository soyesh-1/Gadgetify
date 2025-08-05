import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock class for the repository dependency.
class MockAuthRepository extends Mock implements IAuthRepository {}

// --- THIS IS THE FIX (Part 1) ---
// Create a "Fake" class that mocktail can use as a placeholder.
class FakeAuthEntity extends Fake implements AuthEntity {}

void main() {
  late SignUpUseCase signUpUseCase;
  late MockAuthRepository mockAuthRepository;

  // --- THIS IS THE FIX (Part 2) ---
  // Use setUpAll to register the fallback value once for all tests in this file.
  setUpAll(() {
    registerFallbackValue(FakeAuthEntity());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(mockAuthRepository);
  });

  const tAuthEntity = AuthEntity(
    name: 'Test User',
    email: 'test@test.com',
    password: 'password',
  );

  test('should call authRepository.signup with correct entity', () async {
    // Arrange: Stub the repository's signup method to return success.
    // The `any(named: 'user')` will now work because we registered a fallback.
    when(
      () => mockAuthRepository.signup(user: any(named: 'user')),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await signUpUseCase(tAuthEntity);

    // Assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.signup(user: tAuthEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
