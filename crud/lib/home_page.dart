import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/firestore.dart'; // Ensure the path to this import is correct
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void openNoteBox([String? docID]) {
    if (docID != null) {
      // Fetch the note text from Firestore for editing
      firestoreService.getNoteByID(docID).then((noteText) {
        // Set the existing note text in the text controller
        textController.text = noteText;
        // Show the dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Edit Note'),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter your note here',
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await firestoreService.updateNote(docID, textController.text);
                  textController.clear();
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      }).catchError((e) {
        print('Failed to fetch note: $e');
      });
    } else {
      // Clear the controller for adding a new note
      textController.clear();
      // Show the dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add a Note'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Enter your note here',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await firestoreService.addNote(textController.text);
                textController.clear();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  void deleteNoteBox(String docID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await firestoreService.deleteNote(docID);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(), // Pass no argument to add a new note
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notes..'));
          }

          List noteList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = noteList[index];
              String docID = document.id;

              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String noteText = data['note'];

              return ListTile(
                title: Text(noteText),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => openNoteBox(docID),
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => deleteNoteBox(docID),
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
