import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:fe_catat_uangku/services/note_service.dart';
part 'note_by_wallet_event.dart';
part 'note_by_wallet_state.dart';

class NoteByWalletBloc extends Bloc<FetchNotesByWallet, NoteByWalletState> {
  final NoteService noteService;

  NoteByWalletBloc(this.noteService) : super(NoteByWalletInitial()) {
    on<FetchNotesByWallet>((event, emit) async {
      emit(NoteByWalletLoading());
      try {
        final notes = await noteService.getNotesByWallet(event.walletId);
        notes.sort((a, b) => b.date.compareTo(a.date));
        emit(NoteByWalletLoaded(notes));
      } catch (e) {
        emit(NoteByWalletError(e.toString()));
      }
    });
  }
}
