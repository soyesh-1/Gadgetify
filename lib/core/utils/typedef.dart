// lib/core/utils/typedef.dart
import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';

typedef DataState<T> = Future<Either<Failure, T>>;
