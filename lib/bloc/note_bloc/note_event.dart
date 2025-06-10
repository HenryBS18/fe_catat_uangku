part of 'note_bloc.dart';

abstract class NoteEvent {}

class FetchNotes extends NoteEvent {
  final String? type;
  final String? category;
  final String? startDate;
  final String? endDate;

  FetchNotes({this.type, this.category, this.startDate, this.endDate});
}

class FetchNotesByWallet extends NoteEvent {
  final String walletId;

  FetchNotesByWallet(this.walletId);
}

class CreateNote extends NoteEvent {
  final NoteModel note;

  CreateNote(this.note);
}

class UpdateNote extends NoteEvent {
  final String id;
  final NoteModel note;

  UpdateNote(this.id, this.note);
}

class DeleteNote extends NoteEvent {
  final String id;
  final String walletId;

  DeleteNote(this.id, this.walletId);
}
