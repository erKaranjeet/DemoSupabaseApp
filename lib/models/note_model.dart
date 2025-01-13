class NoteModel {

  int? id;
  String? noteContent, createdAt;

  NoteModel({this.id, this.noteContent, this.createdAt});

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      createdAt: map['created_at'] as String,
      noteContent: map['note_content'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note_content': noteContent,
    };
  }
}