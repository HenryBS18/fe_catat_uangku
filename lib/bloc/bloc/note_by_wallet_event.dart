part of 'note_by_wallet_bloc.dart';

abstract class NoteByWalletEvent {}

class FetchNotesByWallet extends NoteByWalletEvent {
  final String walletId;
  FetchNotesByWallet(this.walletId);
}
