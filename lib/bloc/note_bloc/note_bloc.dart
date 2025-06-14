import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:fe_catat_uangku/services/note_service.dart';


part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService noteService;

  NoteBloc(this.noteService) : super(NoteInitial()) {
    on<FetchNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await noteService.getAllNotes();
        notes.sort((a, b) => b.date.compareTo(a.date)); // Sort by newest first
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}
