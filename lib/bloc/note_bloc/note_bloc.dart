
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:fe_catat_uangku/services/note_service.dart';

part 'note_state.dart';
part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService noteService;

  NoteBloc(this.noteService) : super(NoteInitial()) {
    on<FetchNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await noteService.getAllNotes(
          type: event.type,
          category: event.category,
          startDate: event.startDate,
          endDate: event.endDate,
        );

        notes.sort((a, b) => b.date.compareTo(a.date)); // sort dari terbaru
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<FetchNotesByWallet>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await noteService.getNotesByWallet(event.walletId);
        notes.sort((a, b) => b.date.compareTo(a.date));
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<CreateNote>((event, emit) async {
      emit(NoteLoading());
      try {
        final success = await noteService.createNote(event.note);
        if (success) {
          add(FetchNotesByWallet(event.note.walletId));
        }
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<UpdateNote>((event, emit) async {
      emit(NoteLoading());
      try {
        final success = await noteService.updateNote(event.id, event.note);
        if (success) {
          add(FetchNotesByWallet(event.note.walletId));
        }
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      emit(NoteLoading());
      try {
        final success = await noteService.deleteNote(event.id);
        if (success) {
          add(FetchNotesByWallet(event.walletId));
        }
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}