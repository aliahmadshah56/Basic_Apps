import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new note
  Future<void> addNote(String note) async {
    try {
      await _db.collection('notes').add({
        'note': note,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Failed to add note: $e');
    }
  }

  // Update an existing note
  Future<void> updateNote(String docID, String note) async {
    try {
      await _db.collection('notes').doc(docID).update({
        'note': note,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Failed to update note: $e');
    }
  }

  // Get a stream of notes
  Stream<QuerySnapshot> getNotesStream() {
    return _db.collection('notes').orderBy('timestamp').snapshots();
  }

  // Get a single note by ID
  Future<String> getNoteByID(String docID) async {
    try {
      DocumentSnapshot doc = await _db.collection('notes').doc(docID).get();
      return (doc.data() as Map<String, dynamic>)['note'] ?? '';
    } catch (e) {
      print('Failed to fetch note: $e');
      return '';
    }
  }

  // Delete a note by ID
  Future<void> deleteNote(String docID) async {
    try {
      await _db.collection('notes').doc(docID).delete();
    } catch (e) {
      print('Failed to delete note: $e');
    }
  }
}
