// lib/app/use_case/use_case.dart
import 'package:gadgetify/core/utils/typedef.dart';

abstract class UseCase<Type, Params> {
  DataState<Type> call(Params params);
}

class NoParams {}
