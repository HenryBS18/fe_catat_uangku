part of 'arus_kas_bloc.dart';

abstract class ArusKasState {}

class ArusKasInitial extends ArusKasState {}

class ArusKasLoading extends ArusKasState {}

class ArusKasLoaded extends ArusKasState {
  final ArusKas data;
  ArusKasLoaded(this.data);
}

class ArusKasError extends ArusKasState {
  final String message;
  ArusKasError(this.message);
}
