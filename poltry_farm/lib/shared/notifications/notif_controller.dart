import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:firebase_core/firebase_core.dart';

import 'notif_service.dart';

class PfNotificationController {
  static Future<void> onActionReceivedMethod(ReceivedAction action) async {
    await Firebase.initializeApp();

    final data = action.payload ?? {};
    PfNotificationHandler.handleTapNavigate(
        data, PfNotificationsService.entity);
  }
}
