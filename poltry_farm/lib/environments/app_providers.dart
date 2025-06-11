import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseFirestore>(
          lazy: false,
          create: (context) => FirebaseFirestore.instance,
        ),
        RepositoryProvider<FirebaseAuth>(
          lazy: false,
          create: (context) => FirebaseAuth.instance,
        ),
        RepositoryProvider<AuthRepository>(
          lazy: false,
          create: (context) => AuthRepository(),
        ),
      ],
      child: child,
    );
  }
}
