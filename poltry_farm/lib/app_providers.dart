import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/router.dart';
import 'package:poltry_farm/shared/notifications/notif_service.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          lazy: false,
          create: (context) => AuthRepository(
            auth: FirebaseAuth.instance,
            firestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        RepositoryProvider<PfNotificationsService>(
          lazy: false,
          create: (context) {
            final service = PfNotificationsService();
            service
              ..configure(
                onMessageOpenedApp: (notificationsResponse) {
                  PfNotificationHandler.navigate(
                    notification: notificationsResponse,
                    onChatDetailsRedirect: (notifsRes) {
                      PfRouter.router.pushNamed(
                        PfPaths.home.name,
                      );
                    },
                  );
                },
              )
              ..initialize(context.read<AuthRepository>());

            return service;
          },
        ),
      ],
      child: child,
    );
  }
}
