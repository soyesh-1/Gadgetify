import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadgetify/features/auth/presentation/view/signup_view.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
  });

  Widget buildTestableWidget() {
    return BlocProvider<AuthCubit>.value(
      value: mockAuthCubit,
      child: const MaterialApp(home: SignUpView()),
    );
  }

  testWidgets(
    'SignUpView should show loading indicator when state is AuthLoading',
    (WidgetTester tester) async {
      // Arrange: When the cubit's state is requested, return AuthLoading.
      when(() => mockAuthCubit.state).thenReturn(AuthLoading());

      // Act: Build the widget.
      await tester.pumpWidget(buildTestableWidget());

      // Assert: Verify that the CircularProgressIndicator is displayed
      // and the ElevatedButton is not.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsNothing);
    },
  );
}
