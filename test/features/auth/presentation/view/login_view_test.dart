import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadgetify/features/auth/presentation/view/login_view.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock the AuthCubit to control its state during the test.
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
  });

  // A helper function to build the widget for testing.
  Widget buildTestableWidget() {
    return BlocProvider<AuthCubit>.value(
      value: mockAuthCubit,
      child: const MaterialApp(home: LoginView()),
    );
  }

  testWidgets('LoginView should display initial UI elements', (
    WidgetTester tester,
  ) async {
    // Arrange: When the cubit's state is requested, return AuthInitial.
    when(() => mockAuthCubit.state).thenReturn(AuthInitial());

    // Act: Build the widget.
    await tester.pumpWidget(buildTestableWidget());

    // Assert: Verify that the main title and button are on the screen.
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
