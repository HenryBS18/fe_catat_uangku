part of 'note_by_wallet_bloc.dart';

abstract class NoteByWalletState {}

class NoteByWalletInitial extends NoteByWalletState {}

class NoteByWalletLoading extends NoteByWalletState {}

class NoteByWalletLoaded extends NoteByWalletState {
  final List<NoteModel> notes;
  NoteByWalletLoaded(this.notes);
}

class NoteByWalletError extends NoteByWalletState {
  final String message;
  NoteByWalletError(this.message);
}
