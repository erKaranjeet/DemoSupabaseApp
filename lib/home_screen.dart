import 'dart:io';

import 'package:demo_supabase_app/auth/auth_service.dart';
import 'package:demo_supabase_app/connection/note_database.dart';
import 'package:demo_supabase_app/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final noteController = TextEditingController();
  final authService = AuthService();
  final database = NoteDatabase();

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Note'),
        content: TextField(
          controller: noteController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              saveNote();
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void updateNote(NoteModel noteModel) {
    noteController.text = noteModel.noteContent ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Note'),
        content: TextField(
          controller: noteController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              database.updateNoteById(noteModel, noteController.text.toString());
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void deleteNote(NoteModel noteModel) {
    noteController.text = noteModel.noteContent ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              database.deleteNote(noteModel);
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void saveNote() async {
    final noteModel = NoteModel(
      noteContent: noteController.text.toString(),
    );
    database.createNote(noteModel);
  }

  @override
  Widget build(BuildContext context) {
    final emailId = authService.getUserDetails();
    return Scaffold(
      appBar: AppBar(
        title: Text(emailId.toString()),
        actions: [
          IconButton(
            onPressed: () {
              pickAndUploadPicture();
            },
            icon: Icon(Icons.upload),
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: database.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final notes = snapshot.data!;
          
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  notes[index].noteContent ?? '',
                ),
                trailing: SizedBox(
                  width: 100.0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateNote(notes[index]);
                        },
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteNote(notes[index]);
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void logout() async {
    await authService.signOut();
  }

  void pickAndUploadPicture() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'uploads/$fileName';

      await Supabase.instance.client.storage.from('pictures').upload(path, 
          File(file.path)).then((value) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File uploaded successfully!'))),
      );
    }
  }
}
