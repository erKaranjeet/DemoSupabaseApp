import 'package:demo_supabase_app/models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase {

  //Database -> Notes
  final database = Supabase.instance.client.from('notes');

  //Create note entry
  Future createNote(NoteModel model) async {
    await database.insert(model.toMap());
  }

  //Read notes from Supabase
  final stream = Supabase.instance.client.from('notes').stream(
    primaryKey: ['id'],
  ).map((data) => data.map((noteMap) => NoteModel.fromMap(noteMap)).toList());

  //Update notes from Supabase by Id
  Future updateNoteById(NoteModel oldNote, String content) async {
    await database.update({
      'note_content': content,
    }).eq('id', oldNote.id!);
  }

  //Delete  note from Supabase
  Future deleteNote(NoteModel model) async {
    await database.delete().eq('id', model.id!);
  }
}