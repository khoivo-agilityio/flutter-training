import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseRepository {
  /// The Firebase Authentication instance.
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// The Firestore instance.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// The Firebase Storage instance.
  final firebaseStorage = FirebaseStorage.instance;

  /// Returns the currently authenticated user.
  User? get currentUser => auth.currentUser;

  /// Returns the ID of the currently authenticated user.
  /// If the user is not authenticated, an empty string is returned.
  String get uid => currentUser?.uid ?? "";

  /// Returns `true` if the user is authenticated, `false` otherwise.
  bool get isAuthenticated => currentUser != null;
}
