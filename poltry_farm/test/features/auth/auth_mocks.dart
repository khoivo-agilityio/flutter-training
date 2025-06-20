import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';

@GenerateMocks([
  AuthRepository,
  FirebaseAuth,
  FirebaseFirestore,
  FirebaseStorage,
  User,
  UserCredential,
  DocumentSnapshot,
  DocumentReference,
  CollectionReference,
])
void main() {}
